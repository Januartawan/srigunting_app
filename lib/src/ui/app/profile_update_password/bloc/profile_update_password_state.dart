part of 'profile_update_password_bloc.dart';

@immutable
sealed class ProfileUpdatePasswordState extends AState {}

final class ProfileUpdatePasswordInitial extends ProfileUpdatePasswordState {}

final class ProfileUpdatePasswordLoading extends ProfileUpdatePasswordState {}

final class ProfileUpdatePasswordExecuteError
    extends ProfileUpdatePasswordState {
  final String error;

  ProfileUpdatePasswordExecuteError({required this.error});
}

final class ProfileUpdatePasswordExecuteSuccess
    extends ProfileUpdatePasswordState {}
