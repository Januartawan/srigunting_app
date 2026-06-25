part of 'profile_show_bloc.dart';

@immutable
sealed class ProfileShowState extends AState {}

final class ProfileShowInitial extends ProfileShowState {}

class ProfileShowLoaded extends ProfileShowState {
  final Guide? dataGuide;
  final Guide? detailAccountData;

  ProfileShowLoaded({this.dataGuide, this.detailAccountData});
}

class ProfileShowLoading extends ProfileShowState {}

class ProfileShowError extends ProfileShowState {
  final String error;

  ProfileShowError({required this.error});
}
