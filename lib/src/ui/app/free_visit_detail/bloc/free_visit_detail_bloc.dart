import 'package:meta/meta.dart';
import 'package:srigunting_app/src/domain/free_visit.dart';
import 'package:srigunting_app/src/infrastructure/state_management/bloc/bloc_state.dart';
import 'package:srigunting_app/src/infrastructure/state_management/event.dart';
import 'package:srigunting_app/src/infrastructure/state_management/state.dart';
import 'package:srigunting_app/src/repository/rest/tool/network_func.dart';
import 'package:srigunting_app/src/repository/free_visit_detail_repository.dart';
part 'free_visit_detail_event.dart';
part 'free_visit_detail_state.dart';
class FreeVisitDetailBloc
    extends ABlocManagement<FreeVisitDetailEvent, FreeVisitDetailState> {
  final FreeVisitDetailRepository _freeVisitDetailRepository;
  FreeVisitDetailBloc(this._freeVisitDetailRepository)
      : super(FreeVisitDetailInitial()) {
    on<FreeVisitDetailInitialEvent>((event, emit) async {
      try {
        emit(FreeVisitDetailLoading());
        var res = await _freeVisitDetailRepository.showFreeVisitDetail();
        responseHandler<FreeVisit>(res, onSuccess: (response) {
          emit(FreeVisitDetailLoaded(dataVisit: response ?? FreeVisit()));
        }, onError: (dioError, code, errorMessage) {
          emit(FreeVisitDetailError(error: errorMessage));
        });
      } catch (e) {
        emit(FreeVisitDetailError(error: e.toString()));
      }
    });
  }
}