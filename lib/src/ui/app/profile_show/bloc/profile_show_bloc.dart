import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:srigunting_app/src/domain/guide.dart';
import 'package:srigunting_app/src/infrastructure/state_management/bloc/bloc_state.dart';
import 'package:srigunting_app/src/infrastructure/state_management/event.dart';
import 'package:srigunting_app/src/infrastructure/state_management/state.dart';
import 'package:srigunting_app/src/repository/guide_repository.dart';
import 'package:srigunting_app/src/repository/rest/tool/network_func.dart';

part 'profile_show_event.dart';
part 'profile_show_state.dart';

class ProfileShowBloc
    extends ABlocManagement<ProfileShowEvent, ProfileShowState> {
  final GuideRepository _guideRepository;

  ProfileShowBloc(this._guideRepository) : super(ProfileShowInitial()) {
    on<ProfileShowInitialEvent>((event, emit) async {
      try {
        emit(ProfileShowLoading());

        // Call both showGuide and detailAccountSrigunting
        var showGuideRes = await _guideRepository.showGuide();
        var detailAccountRes = await _guideRepository.detailAccountSrigunting();

        // Handle showGuide response
        responseHandler<Guide>(showGuideRes, onSuccess: (showGuideData) {
          // Handle detailAccountSrigunting response
          responseHandler<Guide>(detailAccountRes,
              onSuccess: (detailAccountData) {
            emit(ProfileShowLoaded(
              dataGuide: showGuideData,
              detailAccountData: detailAccountData,
            ));
          }, onError: (dioError, code, errorMessage) {
            emit(ProfileShowError(error: errorMessage));
          });
        }, onError: (dioError, code, errorMessage) {
          emit(ProfileShowError(error: errorMessage));
        });
      } catch (e) {
        emit(ProfileShowError(error: e.toString()));
      }
    });
  }
}
