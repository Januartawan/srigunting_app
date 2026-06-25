import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:srigunting_app/src/domain/reward.dart';
import 'package:srigunting_app/src/domain/balance.dart';
import 'package:srigunting_app/src/domain/transaction.dart';
import 'package:srigunting_app/src/domain/pagination.dart';
import 'package:srigunting_app/src/infrastructure/state_management/bloc/bloc_state.dart';
import 'package:srigunting_app/src/infrastructure/state_management/event.dart';
import 'package:srigunting_app/src/infrastructure/state_management/state.dart';
import 'package:srigunting_app/src/repository/rest/tool/network_func.dart';
import 'package:srigunting_app/src/repository/reward_repository.dart';
import 'package:srigunting_app/src/repository/pagination.dart';

part 'redeem_point_event.dart';
part 'redeem_point_state.dart';

class RedeemPointBloc
    extends ABlocManagement<RedeemPointEvent, RedeemPointState> {
  final RewardRepository _rewardRepository;

  RedeemPointBloc(this._rewardRepository) : super(RedeemPointInitial()) {
    on<RedeemPointInitialEvent>((event, emit) async {
      try {
        emit(RedeemPointInitialLoading());

        final res = await Future.wait([
          _rewardRepository.showPointUndian(),
          _rewardRepository.showPointReward(),
          _rewardRepository.fetchReward(),
          _rewardRepository.fetchPointHistoryPaginated(
              PaginationRequest(page: 1, perPage: 10)),
        ]);

        Balance? totalPointUndian;
        Balance? availablePointReward;
        List<Reward>? rewards;
        List<Transaction>? pointHistory;
        dynamic pagination;
        String? error;

        await responseHandler<Balance>(res[0], onSuccess: (data) {
          totalPointUndian = data;
        }, onError: (dioError, code, errorMessage) {
          error = errorMessage;
        });
        await responseHandler<Balance>(res[1], onSuccess: (data) {
          availablePointReward = data;
        }, onError: (dioError, code, errorMessage) {
          error = errorMessage;
        });
        await responseHandler<List<Reward>>(res[2], onSuccess: (data) {
          rewards = data;
        }, onError: (dioError, code, errorMessage) {
          error = errorMessage;
        });
        await responseHandler<Pagination<Transaction>>(res[3],
            onSuccess: (data) {
          pointHistory = data?.data ?? [];
          pagination = data;
        }, onError: (dioError, code, errorMessage) {
          error = errorMessage;
        });

        if (error != null) {
          emit(RedeemPointInitialError(error: error!));
        } else {
          emit(RedeemPointInitialLoaded(
            dataReward: rewards,
            totalPointUndian: totalPointUndian,
            availablePointReward: availablePointReward,
            dataPointHistory: pointHistory,
            pagination: pagination,
          ));
        }
      } catch (e) {
        emit(RedeemPointInitialError(error: e.toString()));
      }
    });
    on<RedeemPointLoadMoreHistoryEvent>((event, emit) async {
      try {
        // Ambil state terakhir
        final currentState = state;
        List<Transaction> currentHistory = [];
        dynamic currentPagination;
        if (currentState is RedeemPointInitialLoaded) {
          currentHistory = currentState.dataPointHistory ?? [];
          currentPagination = currentState.pagination;
        } else if (currentState is RedeemPointLoadMoreHistoryLoaded) {
          currentHistory = currentState.dataPointHistory;
          currentPagination = currentState.pagination;
        }
        emit(RedeemPointLoadMoreHistoryLoading(
            dataPointHistory: currentHistory, pagination: currentPagination));
        var res = await _rewardRepository.fetchPointHistoryPaginated(
            PaginationRequest(page: event.page, perPage: 10));
        await responseHandler<Pagination<Transaction>>(res,
            onSuccess: (response) {
          final newList = List<Transaction>.from(currentHistory)
            ..addAll(response?.data ?? []);
          emit(RedeemPointLoadMoreHistoryLoaded(
              dataPointHistory: newList, pagination: response));
        }, onError: (dioError, code, errorMessage) {
          emit(RedeemPointLoadMoreHistoryError(
              error: errorMessage,
              dataPointHistory: currentHistory,
              pagination: currentPagination));
        });
      } catch (e) {
        emit(RedeemPointLoadMoreHistoryError(
            error: e.toString(), dataPointHistory: [], pagination: null));
      }
    });
  }
}
