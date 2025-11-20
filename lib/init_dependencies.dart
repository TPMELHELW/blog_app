import 'package:blog_app/core/common/cubit/user_cubit/user_cubit.dart';
import 'package:blog_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:blog_app/features/auth/data/source/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user_use_case.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_up_use_case.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final servicesLocator = GetIt.instance;
const supabaseUrl = 'https://rvodqmbqiehftynxavle.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJ2b2RxbWJxaWVoZnR5bnhhdmxlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI5NDc5MjgsImV4cCI6MjA3ODUyMzkyOH0.aDw2cdK24bFhXQgfLyDbpQZqLwPpp-_LflL22VkdYao';

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );

  servicesLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  servicesLocator
    ..registerLazySingleton(
      () => AuthRemoteDataSourceImpl(
        supabaseClient: servicesLocator<SupabaseClient>(),
      ),
    )
    ..registerLazySingleton(
      () => AuthRepositoryImpl(
        authRemoteDataSource: servicesLocator<AuthRemoteDataSourceImpl>(),
      ),
    )
    ..registerLazySingleton(
      () =>
          SignUpUseCase(authRepository: servicesLocator<AuthRepositoryImpl>()),
    )
    ..registerLazySingleton(
      () =>
          SignInUseCase(authRepository: servicesLocator<AuthRepositoryImpl>()),
    )
    ..registerLazySingleton(
      () => CurrentUserUseCase(
        authRepository: servicesLocator<AuthRepositoryImpl>(),
      ),
    )
    ..registerFactory(() => UserCubit())
    ..registerFactory(
      () => AuthBloc(
        signUpUseCase: servicesLocator<SignUpUseCase>(),
        signInUseCase: servicesLocator<SignInUseCase>(),
        currentUserUseCase: servicesLocator<CurrentUserUseCase>(),
        userCubit: servicesLocator<UserCubit>(),
      ),
    );
}
