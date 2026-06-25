import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:srigunting_app/src/infrastructure/state_management/bloc/bloc_state.dart';
import 'package:srigunting_app/src/infrastructure/state_management/event.dart';
import 'package:srigunting_app/src/infrastructure/state_management/state.dart';
import 'package:srigunting_app/src/repository/guide_repository.dart';
import 'package:srigunting_app/src/repository/request/register_request.dart';
import 'package:srigunting_app/src/repository/rest/tool/network_func.dart';
import 'package:srigunting_app/src/domain/atribute.dart';
import 'package:srigunting_app/src/repository/atribute_repository.dart';

part 'profile_update_event.dart';
part 'profile_update_state.dart';

class ProfileUpdateBloc
    extends ABlocManagement<ProfileUpdateEvent, ProfileUpdateState> {
  final GuideRepository _guideRepository;
  final AtributeRepository _atributeRepository;

  ProfileUpdateBloc(this._guideRepository, this._atributeRepository)
      : super(ProfileUpdateInitial()) {
    on<ProfileUpdateExecuteEvent>((event, emit) async {
      try {
        emit(ProfileUpdateExecuteLoading());

        var res = await _guideRepository.updateGuide(event.payload);

        responseHandler(res, onSuccess: (response) {
          emit(ProfileUpdateExecuteSuccess());
        }, onError: (dioError, code, errorMessage) {
          emit(ProfileUpdateExecuteError(error: errorMessage));
        });
      } catch (e) {
        emit(ProfileUpdateExecuteError(error: e.toString()));
      }
    });

    on<ProfileUpdateInitialEvent>((event, emit) async {
      emit(
          ProfileUpdateReligionLoading()); // Bisa buat loading state baru jika mau
      try {
        final results = await Future.wait([
          _atributeRepository.fetchReligion(),
          _atributeRepository.fetchGender(),
        ]);
        List<Atribute> religions = [];
        List<Atribute> genders = [];
        String? error;
        await responseHandler<List<Atribute>>(results[0], onSuccess: (list) {
          religions = list ?? [];
        }, onError: (dioError, code, errorMessage) {
          error = errorMessage;
        });
        await responseHandler<List<Atribute>>(results[1], onSuccess: (list) {
          genders = list ?? [];
        }, onError: (dioError, code, errorMessage) {
          error = error ?? errorMessage; // Prioritaskan error pertama
        });
        if (error != null) {
          emit(ProfileUpdateInitialLoaded(
            religions: religions,
            genders: genders,
            error: error,
          ));
        } else {
          emit(ProfileUpdateInitialLoaded(
            religions: religions,
            genders: genders,
          ));
        }
      } catch (e) {
        emit(ProfileUpdateInitialLoaded(
          religions: [],
          genders: [],
          error: e.toString(),
        ));
      }
    });

    on<ProfileUpdateReligionChangedEvent>((event, emit) async {
      // This event expects the current religion list to be available in state
      if (state is ProfileUpdateReligionLoaded) {
        final loaded = state as ProfileUpdateReligionLoaded;
        emit(ProfileUpdateReligionLoaded(
          religions: loaded.religions,
          selectedReligion: event.religionId,
        ));
      }
    });

    on<ProfileUpdateFetchGenderEvent>((event, emit) async {
      emit(ProfileUpdateGenderLoading());
      try {
        final result = await _atributeRepository.fetchGender();
        responseHandler<List<Atribute>>(result, onSuccess: (list) {
          emit(ProfileUpdateGenderLoaded(genders: list ?? []));
        }, onError: (dioError, code, errorMessage) {
          emit(ProfileUpdateGenderError(error: errorMessage));
        });
      } catch (e) {
        emit(ProfileUpdateGenderError(error: e.toString()));
      }
    });

    on<ProfileUpdateGenderChangedEvent>((event, emit) async {
      if (state is ProfileUpdateGenderLoaded) {
        final loaded = state as ProfileUpdateGenderLoaded;
        emit(ProfileUpdateGenderLoaded(
          genders: loaded.genders,
          selectedGender: event.genderId,
        ));
      }
    });
  }
}
