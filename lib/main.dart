import 'package:blog_app/core/common/cubit/button_cubit/button_cubit.dart';
import 'package:blog_app/core/common/cubit/user_cubit/user_cubit.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ButtonCubit()),
        BlocProvider(create: (_) => UserCubit()),

        BlocProvider(create: (_) => servicesLocator<AuthBloc>()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(CurrentUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<UserCubit, UserState, bool>(
        selector: (state) {
          return state is UserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return LoginPage();
          }
          return LoginPage();
        },
      ),
    );
  }
}
