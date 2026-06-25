part of 'profile_update_username_bloc.dart';

@immutable
sealed class ProfileUpdateUsernameEvent extends AStateEvent {}

final class ProfileUpdateUsernameExecuteEvent
    extends ProfileUpdateUsernameEvent {
  final String username;
  final String password;
  ProfileUpdateUsernameExecuteEvent(
      {required this.username, required this.password});
}
