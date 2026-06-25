part of 'profile_update_password_bloc.dart';

@immutable
sealed class ProfileUpdatePasswordEvent extends AStateEvent {}

final class ProfileUpdatePasswordExecute extends ProfileUpdatePasswordEvent {
  final String? oldPassword;
  final String? newPassword;

  ProfileUpdatePasswordExecute({this.oldPassword, this.newPassword});
}
