part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthSignup extends AuthEvent {
  final String email;
  final String name;
  final String password;
  AuthSignup({required this.email, required this.name, required this.password});
}

class AuthSignIn extends AuthEvent {
  final String email;

  final String password;
  AuthSignIn({required this.email, required this.password});
}

class AuthIsUserLoggedIn extends AuthEvent{}
