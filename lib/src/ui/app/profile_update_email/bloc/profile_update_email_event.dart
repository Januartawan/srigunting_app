part of 'profile_update_email_bloc.dart';

@immutable
sealed class ProfileUpdateEmailEvent extends AStateEvent {}

final class ProfileUpdateEmailExecuteEvent extends ProfileUpdateEmailEvent {
  final String email;
  final String password;
  ProfileUpdateEmailExecuteEvent({required this.email, required this.password});
}
