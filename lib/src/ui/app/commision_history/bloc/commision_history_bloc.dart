import 'package:meta/meta.dart';
import 'package:srigunting_app/src/domain/balance.dart';
import 'package:srigunting_app/src/domain/guide.dart';
import 'package:srigunting_app/src/domain/pagination.dart';
import 'package:srigunting_app/src/domain/transaction.dart';
import 'package:srigunting_app/src/infrastructure/state_management/bloc/bloc_state.dart';
import 'package:srigunting_app/src/infrastructure/state_management/event.dart';
import 'package:srigunting_app/src/infrastructure/state_management/state.dart';
import 'package:srigunting_app/src/repository/balance_repopsitory.dart';
import 'package:srigunting_app/src/repository/guide_repository.dart';
import 'package:srigunting_app/src/repository/pagination.dart';
import 'package:srigunting_app/src/repository/rest/tool/network_func.dart';
import 'package:srigunting_app/src/repository/reward_repository.dart';
part 'commision_history_event.dart';
part 'commision_history_state.dart';
class CommisionHistoryBloc
    extends ABlocManagement<CommisionHistoryEvent, CommisionHistoryState> {
  final BalanceRepopsitory _balanceRepopsitory;
  final GuideRepository _guideRepository;
  final RewardRepository _rewardRepository;
  CommisionHistoryBloc(
      this._balanceRepopsitory, this._guideRepository, this._rewardRepository)
      : super(CommisionHistoryInitial()) {
    on<CommisionHistoryInitialEvent>((event, emit) async {
      try {
        emit(CommisionInitialLoading());
        var dataState = CommisionInitialLoaded(
          dataBalance: Balance(),
          dataGuide: Guide(),
          dataPointReward: Balance(),
          dataCommissionHistory: const [],
          dataPointHistory: const [],
        );
        var res = await Future.wait([
          _balanceRepopsitory.showBalance(),
          _guideRepository.showGuide(),
          _rewardRepository.showPointReward(),
          _balanceRepopsitory
              .fetchHistoryTransaction(PaginationRequest(page: 1, perPage: 10)),
        ]);
        await responseHandler<Balance>(res[0], onSuccess: (response) {
          dataState = dataState.copyWith(dataBalance: response);
        }, onError: (dioError, code, errorMessage) {
          emit(CommisionInitialError(error: errorMessage));
        });
        await responseHandler<Guide>(res[1], onSuccess: (response) {
          dataState = dataState.copyWith(dataGuide: response);
        }, onError: (dioError, code, errorMessage) {
          emit(CommisionInitialError(error: errorMessage));
        });
        await responseHandler<Balance>(res[2], onSuccess: (response) {
          dataState = dataState.copyWith(dataPointReward: response);
        }, onError: (dioError, code, errorMessage) {
          emit(CommisionInitialError(error: errorMessage));
        });
        await responseHandler<Pagination<Transaction>>(res[3],
            onSuccess: (response) {
          dataState = dataState.copyWith(
            dataCommissionHistory: response?.data ?? [],
            pagination: response,
          );
        }, onError: (dioError, code, errorMessage) {
          emit(CommisionInitialError(error: errorMessage));
        });
        emit(dataState);
      } catch (e) {
        emit(CommisionInitialError(error: e.toString()));
      }
    });
    on<CommisionHistoryLoadMoreEvent>((event, emit) async {
      try {
        final currentState = state;
        List<Transaction> currentList = [];
        Pagination<Transaction>? currentPagination;
        if (currentState is CommisionInitialLoaded) {
          currentList = currentState.dataCommissionHistory;
          currentPagination = currentState.pagination;
        } else if (currentState is CommisionLoadMoreLoaded) {
          currentList = currentState.dataCommissionHistory;
          currentPagination = currentState.pagination;
        }
        emit(CommisionLoadMoreLoading(
          dataCommissionHistory: currentList,
          pagination: currentPagination,
        ));
        var res = await _balanceRepopsitory.fetchHistoryTransaction(
            PaginationRequest(page: event.page, perPage: 10));
        responseHandler<Pagination<Transaction>>(res, onSuccess: (response) {
          final newList = <Transaction>[
            ...currentList,
            ...((response?.data ?? []).cast<Transaction>())
          ];
          emit(CommisionLoadMoreLoaded(
            dataCommissionHistory: newList,
            pagination: response,
          ));
        }, onError: (dioError, code, errorMessage) {
          emit(CommisionLoadMoreError(
            error: errorMessage,
            dataCommissionHistory: currentList,
            pagination: currentPagination,
          ));
        });
      } catch (e) {
        final currentState = state;
        List<Transaction> currentList = [];
        Pagination<Transaction>? currentPagination;
        if (currentState is CommisionInitialLoaded) {
          currentList = currentState.dataCommissionHistory;
          currentPagination = currentState.pagination;
        } else if (currentState is CommisionLoadMoreLoaded) {
          currentList = currentState.dataCommissionHistory;
          currentPagination = currentState.pagination;
        }
        emit(CommisionLoadMoreError(
          error: e.toString(),
          dataCommissionHistory: currentList,
          pagination: currentPagination,
        ));
      }
    });
  }
}