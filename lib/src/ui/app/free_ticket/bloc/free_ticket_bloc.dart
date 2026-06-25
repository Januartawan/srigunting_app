import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:srigunting_app/src/domain/free_visit.dart';
import 'package:srigunting_app/src/infrastructure/state_management/bloc/bloc_state.dart';
import 'package:srigunting_app/src/infrastructure/state_management/event.dart';
import 'package:srigunting_app/src/infrastructure/state_management/state.dart';
import 'package:srigunting_app/src/repository/rest/tool/network_func.dart';
import 'package:srigunting_app/src/repository/reward_repository.dart';

part 'free_ticket_event.dart';
part 'free_ticket_state.dart';

class FreeTicketBloc extends ABlocManagement<FreeTicketEvent, FreeTicketState> {
  final RewardRepository _rewardRepository;

  FreeTicketBloc(this._rewardRepository) : super(FreeTicketInitial()) {
    on<FreeTicketInitialEvent>((event, emit) async {
      try {
        emit(FreeTicketLoading());

        var res = await _rewardRepository.showFreeVisit();

        responseHandler<FreeVisit>(res, onSuccess: (response) {
          emit(FreeTicketLoaded(dataVisit: response ?? FreeVisit()));
        }, onError: (dioError, code, errorMessage) {
          emit(FreeTicketError(error: errorMessage));
        });
      } catch (e) {
        emit(FreeTicketError(error: e.toString()));
      }
    });
  }
}
