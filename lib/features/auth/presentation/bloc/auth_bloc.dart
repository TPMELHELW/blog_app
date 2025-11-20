import 'package:blog_app/core/common/cubit/user_cubit/user_cubit.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/data/model/user_model.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user_use_case.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_up_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase _signUpUseCase;
  final SignInUseCase _signInUseCase;
  final CurrentUserUseCase _currentUserUseCase;
  final UserCubit _userCubit;
  AuthBloc({
    required UserCubit userCubit,
    required CurrentUserUseCase currentUserUseCase,
    required SignUpUseCase signUpUseCase,
    required SignInUseCase signInUseCase,
  }) : _signInUseCase = signInUseCase,
       _signUpUseCase = signUpUseCase,
       _currentUserUseCase = currentUserUseCase,
       _userCubit = userCubit,
       super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      final data = await _signUpUseCase(params: event.user);

      data.fold(
        (error) => emit(AuthFailure(message: error.message)),
        (data) => _successEmit(data, emit),
      );
    });

    on<AuthSignIn>((event, emit) async {
      final data = await _signInUseCase(params: event.user);

      data.fold(
        (error) => emit(AuthFailure(message: error.message)),
        (data) => _successEmit(data, emit),
      );
    });

    on<CurrentUserEvent>((event, emit) async {
      final data = await _currentUserUseCase();
      data.fold(
        (error) => emit(AuthFailure(message: error.message)),
        (data) => _successEmit(data, emit),
      );
    });
  }

  void _successEmit(User user, Emitter<AuthState> emit) {
    _userCubit.updateUser(user);
    emit(AuthSuccess(user: user));
  }
}
