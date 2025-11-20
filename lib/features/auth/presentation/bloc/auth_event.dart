part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final UserModel user;

  AuthSignUp({required this.user});
}

final class AuthSignIn extends AuthEvent {
  final UserModel user;

  AuthSignIn({required this.user});
}

final class CurrentUserEvent extends AuthEvent {}
