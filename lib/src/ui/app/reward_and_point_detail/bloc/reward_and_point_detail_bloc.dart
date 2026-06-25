import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:srigunting_app/src/domain/transaction.dart';
import 'package:srigunting_app/src/infrastructure/state_management/bloc/bloc_state.dart';
import 'package:srigunting_app/src/infrastructure/state_management/event.dart';
import 'package:srigunting_app/src/infrastructure/state_management/state.dart';
import 'package:srigunting_app/src/repository/rest/tool/network_func.dart';
// import 'package:srigunting_app/src/repository/reward_and_point_detail_repository.dart';

part 'reward_and_point_detail_event.dart';
part 'reward_and_point_detail_state.dart';

class RewardAndPointDetailBloc extends ABlocManagement<
    RewardAndPointDetailEvent, RewardAndPointDetailState> {
  // final RewardAndPointDetailRepository _rewardAndPointDetailRepository;

  RewardAndPointDetailBloc() : super(RewardAndPointDetailInitial()) {
    //   on<RewardAndPointDetailInitialEvent>((event, emit) async {
    //     try {
    //       emit(RewardAndPointDetailLoading());

    //       var res =
    //           await _rewardAndPointDetailRepository.showRewardAndPointDetail();

    //       responseHandler<Transaction>(res, onSuccess: (response) {
    //         emit(RewardAndPointDetailLoaded(
    //             dataTransaction: response ?? Transaction()));
    //       }, onError: (dioError, code, errorMessage) {
    //         emit(RewardAndPointDetailError(error: errorMessage));
    //       });
    //     } catch (e) {
    //       emit(RewardAndPointDetailError(error: e.toString()));
    //     }
    //   });
  }
}
