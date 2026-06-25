part of 'profile_update_username_bloc.dart';

@immutable
sealed class ProfileUpdateUsernameState extends AState {}

final class ProfileUpdateUsernameInitial extends ProfileUpdateUsernameState {}

final class ProfileUpdateUsernameExecuteLoading
    extends ProfileUpdateUsernameState {}

final class ProfileUpdateUsernameExecuteSuccess
    extends ProfileUpdateUsernameState {}

final class ProfileUpdateUsernameExecuteError
    extends ProfileUpdateUsernameState {
  final String error;
  ProfileUpdateUsernameExecuteError({required this.error});
}
