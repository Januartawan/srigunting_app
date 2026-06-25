part of 'commision_history_bloc.dart';

@immutable
sealed class CommisionHistoryState extends AState {}

final class CommisionHistoryInitial extends CommisionHistoryState {}

final class CommisionInitialLoaded extends CommisionHistoryState {
  final Balance dataBalance;
  final Guide dataGuide;
  final Balance dataPointReward;
  final List<Transaction> dataCommissionHistory;
  final List<Transaction> dataPointHistory;
  final Pagination<Transaction>? pagination;

  CommisionInitialLoaded({
    required this.dataBalance,
    required this.dataGuide,
    required this.dataPointReward,
    required this.dataCommissionHistory,
    required this.dataPointHistory,
    this.pagination,
  });

  CommisionInitialLoaded copyWith({
    Balance? dataBalance,
    Guide? dataGuide,
    Balance? dataPointReward,
    List<Transaction>? dataCommissionHistory,
    List<Transaction>? dataPointHistory,
    Pagination<Transaction>? pagination,
  }) =>
      CommisionInitialLoaded(
        dataBalance: dataBalance ?? this.dataBalance,
        dataGuide: dataGuide ?? this.dataGuide,
        dataPointReward: dataPointReward ?? this.dataPointReward,
        dataCommissionHistory:
            dataCommissionHistory ?? this.dataCommissionHistory,
        dataPointHistory: dataPointHistory ?? this.dataPointHistory,
        pagination: pagination ?? this.pagination,
      );
}

final class CommisionInitialLoading extends CommisionHistoryState {}

final class CommisionInitialError extends CommisionHistoryState {
  final String error;

  CommisionInitialError({required this.error});
}

final class CommisionLoadMoreLoading extends CommisionHistoryState {
  final List<Transaction> dataCommissionHistory;
  final Pagination<Transaction>? pagination;
  CommisionLoadMoreLoading(
      {required this.dataCommissionHistory, this.pagination});
}

final class CommisionLoadMoreLoaded extends CommisionHistoryState {
  final List<Transaction> dataCommissionHistory;
  final Pagination<Transaction>? pagination;
  CommisionLoadMoreLoaded(
      {required this.dataCommissionHistory, this.pagination});
}

final class CommisionLoadMoreError extends CommisionHistoryState {
  final String error;
  final List<Transaction> dataCommissionHistory;
  final Pagination<Transaction>? pagination;
  CommisionLoadMoreError(
      {required this.error,
      required this.dataCommissionHistory,
      this.pagination});
}
