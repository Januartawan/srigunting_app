part of 'register_bloc.dart';

@immutable
sealed class RegisterState extends AState {}

final class RegisterInitial extends RegisterState {}

final class RegisterExecuteLoading extends RegisterState {}

final class RegisterExecuteSuccess extends RegisterState {}

final class RegisterExecuteError extends RegisterState {
  final String error;

  RegisterExecuteError({required this.error});
}
