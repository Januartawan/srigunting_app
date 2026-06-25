part of 'profile_update_bloc.dart';

@immutable
sealed class ProfileUpdateEvent extends AStateEvent {}

final class ProfileUpdateExecuteEvent extends ProfileUpdateEvent {
  final RegisterRequest payload;

  ProfileUpdateExecuteEvent({required this.payload});
}

final class ProfileUpdateFetchReligionEvent extends ProfileUpdateEvent {}

final class ProfileUpdateReligionChangedEvent extends ProfileUpdateEvent {
  final String? religionId;
  ProfileUpdateReligionChangedEvent({this.religionId});
}

final class ProfileUpdateFetchGenderEvent extends ProfileUpdateEvent {}

final class ProfileUpdateGenderChangedEvent extends ProfileUpdateEvent {
  final String? genderId;
  ProfileUpdateGenderChangedEvent({this.genderId});
}

final class ProfileUpdateInitialEvent extends ProfileUpdateEvent {}
