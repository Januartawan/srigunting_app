part of 'profile_update_bloc.dart';

@immutable
sealed class ProfileUpdateState extends AState {}

final class ProfileUpdateInitial extends ProfileUpdateState {}

final class ProfileUpdateInitialError extends ProfileUpdateState {}

final class ProfileUpdateExecuteSuccess extends ProfileUpdateState {}

final class ProfileUpdateExecuteLoading extends ProfileUpdateState {}

final class ProfileUpdateExecuteError extends ProfileUpdateState {
  final String error;

  ProfileUpdateExecuteError({required this.error});
}

final class ProfileUpdateReligionLoading extends ProfileUpdateState {}

final class ProfileUpdateReligionLoaded extends ProfileUpdateState {
  final List<Atribute> religions;
  final String? selectedReligion;
  ProfileUpdateReligionLoaded({required this.religions, this.selectedReligion});
}

final class ProfileUpdateReligionError extends ProfileUpdateState {
  final String error;
  ProfileUpdateReligionError({required this.error});
}

final class ProfileUpdateGenderLoading extends ProfileUpdateState {}

final class ProfileUpdateGenderLoaded extends ProfileUpdateState {
  final List<Atribute> genders;
  final String? selectedGender;
  ProfileUpdateGenderLoaded({required this.genders, this.selectedGender});
}

final class ProfileUpdateGenderError extends ProfileUpdateState {
  final String error;
  ProfileUpdateGenderError({required this.error});
}

final class ProfileUpdateInitialLoaded extends ProfileUpdateState {
  final List<Atribute> religions;
  final List<Atribute> genders;
  final String? selectedReligion;
  final String? selectedGender;
  final String? error;

  ProfileUpdateInitialLoaded({
    required this.religions,
    required this.genders,
    this.selectedReligion,
    this.selectedGender,
    this.error,
  });
}
