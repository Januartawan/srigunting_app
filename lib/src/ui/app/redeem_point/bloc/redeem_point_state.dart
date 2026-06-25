part of 'redeem_point_bloc.dart';

@immutable
sealed class RedeemPointState extends AState {}

final class RedeemPointInitial extends RedeemPointState {}

final class RedeemPointInitialLoading extends RedeemPointState {}

final class RedeemPointInitialLoaded extends RedeemPointState {
  final List<Reward>? dataReward;
  final Balance? totalPointUndian;
  final Balance? availablePointReward;
  final List<Transaction>? dataPointHistory;
  final dynamic pagination;

  RedeemPointInitialLoaded(
      {this.dataReward,
      this.totalPointUndian,
      this.availablePointReward,
      this.dataPointHistory,
      this.pagination});
}

final class RedeemPointInitialError extends RedeemPointState {
  final String error;

  RedeemPointInitialError({required this.error});
}

final class RedeemPointLoadMoreHistoryLoading extends RedeemPointState {
  final List<Transaction> dataPointHistory;
  final dynamic pagination;
  RedeemPointLoadMoreHistoryLoading(
      {required this.dataPointHistory, this.pagination});
}

final class RedeemPointLoadMoreHistoryLoaded extends RedeemPointState {
  final List<Transaction> dataPointHistory;
  final dynamic pagination;
  RedeemPointLoadMoreHistoryLoaded(
      {required this.dataPointHistory, this.pagination});
}

final class RedeemPointLoadMoreHistoryError extends RedeemPointState {
  final String error;
  final List<Transaction> dataPointHistory;
  final dynamic pagination;
  RedeemPointLoadMoreHistoryError(
      {required this.error, required this.dataPointHistory, this.pagination});
}
