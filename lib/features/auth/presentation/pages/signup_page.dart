import 'package:blog_app/core/common/cubit/button_cubit/button_cubit.dart';
import 'package:blog_app/core/common/widgets/basic_app_bar_widget.dart';
import 'package:blog_app/core/functions/show_snack_bar.dart';
import 'package:blog_app/core/helper/app_navigator.dart';
import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/features/auth/data/model/user_model.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field_widget.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final GlobalKey<FormState> _formState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 20.0,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Sign In.',
                // textAlign: TextAlign.center,
                style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
              ),

              Form(
                key: _formState,
                child: Column(
                  spacing: 10.0,
                  children: [
                    AuthFieldWidget(text: 'Name', controller: _nameController),
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
                        if (state is AuthSuccess) {
                          context.read<ButtonCubit>().hide();
                          AppNavigator.pushAndRemove(context, LoginPage());
                          showSnackBar(context, 'Account created successfully');
                        }

                        if (state is AuthFailure) {
                          context.read<ButtonCubit>().hide();
                          showSnackBar(context, state.message);
                        }
                      },
                      child: AuthGradientButton(
                        buttonText: 'Sign Up',
                        onPressed: () {
                          if (!_formState.currentState!.validate()) {
                            return;
                          }
                          context.read<ButtonCubit>().show();
                          final user = UserModel(
                            email: _emailController.text.trim(),
                            name: _nameController.text.trim(),
                            password: _passwordController.text.trim(),
                            id: '',
                          );

                          context.read<AuthBloc>().add(AuthSignUp(user: user));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  AppNavigator.pushAndRemove(context, LoginPage());
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: 'Sign In',
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
      ),
    );
  }
}
