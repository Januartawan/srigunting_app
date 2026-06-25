part of 'profile_update_email_bloc.dart';

@immutable
sealed class ProfileUpdateEmailState extends AState {}

final class ProfileUpdateEmailInitial extends ProfileUpdateEmailState {}

final class ProfileUpdateEmailExecuteLoading extends ProfileUpdateEmailState {}

final class ProfileUpdateEmailExecuteSuccess extends ProfileUpdateEmailState {}

final class ProfileUpdateEmailExecuteError extends ProfileUpdateEmailState {
  final String error;
  ProfileUpdateEmailExecuteError({required this.error});
}
