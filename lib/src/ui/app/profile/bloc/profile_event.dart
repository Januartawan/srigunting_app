part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent extends AStateEvent {}

final class ProfileInitialEvent extends ProfileEvent {}

final class ProfileLogoutExecute extends ProfileEvent {}
