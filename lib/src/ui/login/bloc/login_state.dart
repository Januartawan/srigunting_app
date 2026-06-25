part of 'login_bloc.dart';

@immutable
sealed class LoginState extends AState {}

final class LoginInitial extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginError extends LoginState {
  final String error;

  LoginError({required this.error});
}

final class LoginLoading extends LoginState {}
