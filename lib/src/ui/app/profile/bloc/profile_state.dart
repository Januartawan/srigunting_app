part of 'profile_bloc.dart';

@immutable
sealed class ProfileState extends AState {}

final class ProfileInitial extends ProfileState {}

class ProfileInitialLoaded extends ProfileState {
  final Guide? dataGuide;
  final FreeVisit? dataFreeVisit;

  ProfileInitialLoaded({this.dataGuide, this.dataFreeVisit});

  ProfileInitialLoaded copyWith({
    Guide? dataGuide,
    FreeVisit? dataFreeVisit,
  }) =>
      ProfileInitialLoaded(
        dataGuide: dataGuide ?? this.dataGuide,
        dataFreeVisit: dataFreeVisit ?? this.dataFreeVisit,
      );
}

class ProfileInitialLoading extends ProfileState {}

class ProfileInitialError extends ProfileState {
  final String error;

  ProfileInitialError({required this.error});
}

final class ProfileLogoutError extends ProfileState {}

final class ProfileLogoutLoading extends ProfileState {}

final class ProfileLogoutSuccess extends ProfileState {}
