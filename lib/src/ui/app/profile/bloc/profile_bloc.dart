import 'package:meta/meta.dart';
import 'package:srigunting_app/src/domain/free_visit.dart';
import 'package:srigunting_app/src/domain/guide.dart';
import 'package:srigunting_app/src/infrastructure/services/local_storage/local_storage_repository.dart';
import 'package:srigunting_app/src/infrastructure/state_management/bloc/bloc_state.dart';
import 'package:srigunting_app/src/infrastructure/state_management/event.dart';
import 'package:srigunting_app/src/infrastructure/state_management/state.dart';
import 'package:srigunting_app/src/repository/auth_repository.dart';
import 'package:srigunting_app/src/repository/guide_repository.dart';
import 'package:srigunting_app/src/repository/rest/tool/network_func.dart';
import 'package:srigunting_app/src/repository/reward_repository.dart';
part 'profile_event.dart';
part 'profile_state.dart';
class ProfileBloc extends ABlocManagement<ProfileEvent, ProfileState> {
  final GuideRepository _guideRepository;
  final RewardRepository _rewardRepository;
  final AuthRepository _authRepository;
  final LocalStorageRepository _localStorageRepository;
  ProfileBloc(this._guideRepository, this._rewardRepository,
      this._authRepository, this._localStorageRepository)
      : super(ProfileInitial()) {
    on<ProfileInitialEvent>((event, emit) async {
      try {
        emit(ProfileInitialLoading());
        var dataState = ProfileInitialLoaded(
            dataFreeVisit: FreeVisit(), dataGuide: Guide());
        var res = await Future.wait([
          _guideRepository.showGuide(),
          _rewardRepository.showFreeVisit(),
        ]);
        await responseHandler<Guide>(res[0], onSuccess: (response) {
          dataState = dataState.copyWith(dataGuide: response);
        }, onError: (dioError, code, errorMessage) {
          emit(ProfileInitialError(error: errorMessage));
        });
        await responseHandler<FreeVisit>(res[1], onSuccess: (response) {
          dataState = dataState.copyWith(dataFreeVisit: response);
        }, onError: (dioError, code, errorMessage) {
          emit(ProfileInitialError(error: errorMessage));
        });
        emit(dataState);
      } catch (e) {
        emit(ProfileInitialError(error: e.toString()));
      }
    });
    on<ProfileLogoutExecute>((event, emit) async {
      try {
        emit(ProfileLogoutLoading());
        var res = await _authRepository.logout();
        await responseHandler(res, onSuccess: (response) {
          emit(ProfileLogoutSuccess());
          _localStorageRepository
            ..delete(LocalStorageKey.AUTH_TOKEN)
            ..delete(LocalStorageKey.GUIDE_CODE);
        }, onError: (dioError, code, errorMessage) {
          emit(ProfileLogoutError());
        });
      } catch (e) {
        emit(ProfileLogoutError());
      }
    });
  }
}