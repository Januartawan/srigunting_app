part of 'profile_show_bloc.dart';

@immutable
sealed class ProfileShowEvent extends AStateEvent {}

class ProfileShowInitialEvent extends ProfileShowEvent {}
