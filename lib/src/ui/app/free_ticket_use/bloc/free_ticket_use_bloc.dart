import 'package:meta/meta.dart';
import 'package:srigunting_app/src/domain/free_visit.dart';
import 'package:srigunting_app/src/infrastructure/state_management/bloc/bloc_state.dart';
import 'package:srigunting_app/src/infrastructure/state_management/event.dart';
import 'package:srigunting_app/src/infrastructure/state_management/state.dart';
import 'package:srigunting_app/src/repository/request/free_ticket_request.dart';
import 'package:srigunting_app/src/repository/rest/tool/network_func.dart';
import 'package:srigunting_app/src/repository/reward_repository.dart';
part 'free_ticket_use_event.dart';
part 'free_ticket_use_state.dart';
class FreeTicketUseBloc
    extends ABlocManagement<FreeTicketUseEvent, FreeTicketUseState> {
  final RewardRepository _rewardRepository;
  FreeTicketUseBloc(this._rewardRepository) : super(FreeTicketUseInitial()) {
    on<FreeTicketUseSubmitEvent>((event, emit) async {
      try {
        emit(FreeTicketUseSubmitLoading());
        var res = await _rewardRepository.useFreeTicket(event.request);
        await responseHandler<FreeVisit>(res, onSuccess: (response) {
          emit(FreeTicketUseSubmitSuccess(freeVisit: response ?? FreeVisit()));
        }, onError: (dioError, code, errorMessage) {
          emit(FreeTicketUseSubmitError(error: errorMessage));
        });
      } catch (e) {
        emit(FreeTicketUseSubmitError(error: e.toString()));
      }
    });
  }
}