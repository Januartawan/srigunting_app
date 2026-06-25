part of 'login_bloc.dart';

@immutable
sealed class LoginEvent extends AStateEvent {}

final class LoginExecuteEvent extends LoginEvent {
  final String username;
  final String password;

  LoginExecuteEvent({required this.username, required this.password});
}

final class LoginInitialEvent extends LoginEvent {}
