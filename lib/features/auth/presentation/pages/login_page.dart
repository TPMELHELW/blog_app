import 'dart:developer';

import 'package:blog_app/core/common/cubit/button_cubit/button_cubit.dart';
import 'package:blog_app/core/common/widgets/basic_app_bar_widget.dart';
import 'package:blog_app/core/functions/show_snack_bar.dart';
import 'package:blog_app/core/helper/app_navigator.dart';
import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/features/auth/data/model/user_model.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field_widget.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button_widget.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey();
  // bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(hideBack: true),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (BuildContext context, AuthState state) {
          if (state is AuthInitial) {
            log(state.toString());
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AuthSuccess || state is AuthFailure) {
            log(state.toString());
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 30.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 20.0,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Sign In.',
                      style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Form(
                      key: _formState,
                      child: Column(
                        spacing: 10.0,
                        children: [
                          AuthFieldWidget(
                            text: 'Email',
                            controller: _emailController,
                          ),
                          AuthFieldWidget(
                            text: 'Password',
                            controller: _passwordController,
                          ),
                          SizedBox(height: 10.0),
                          BlocListener<AuthBloc, AuthState>(
                            listener: (BuildContext context, state) {
                              print(state);
                              if (state is AuthSuccess) {
                                context.read<ButtonCubit>().hide();
                                AppNavigator.pushAndRemove(context, BlogPage());
                                showSnackBar(context, 'Login successfully');
                              }

                              if (state is AuthFailure) {
                                context.read<ButtonCubit>().hide();
                                showSnackBar(context, state.message);
                              }
                              // if (state is AuthLoading) {
                              //   isLogin = true;
                              // } else {
                              //   setState(() {
                              //     isLogin = false;
                              //   });
                              // }
                            },
                            child: AuthGradientButton(
                              buttonText: 'Sign In',
                              onPressed: () {
                                if (!_formState.currentState!.validate()) {
                                  return;
                                }
                                context.read<ButtonCubit>().show();
                                final UserModel user = UserModel(
                                  id: '',
                                  email: _emailController.text.trim(),
                                  name: '',
                                  password: _passwordController.text.trim(),
                                );
                                context.read<AuthBloc>().add(
                                  AuthSignIn(user: user),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => AppNavigator.push(context, SignupPage()),

                      child: RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account? ',
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: 'Sign Up',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: AppColors.gradient2,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
        // child:
      ),
    );
  }
}
