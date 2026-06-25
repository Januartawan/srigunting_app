part of 'commision_history_detail_bloc.dart';

@immutable
sealed class CommisionHistoryDetailState extends AState {}

final class CommisionHistoryDetailInitial extends CommisionHistoryDetailState {}

final class CommisionHistoryDetailLoading extends CommisionHistoryDetailState {}

final class CommisionHistoryDetailLoaded extends CommisionHistoryDetailState {
  final Transaction transaction;
  final TransactionDetail transactionDetail;

  CommisionHistoryDetailLoaded({
    required this.transaction,
    required this.transactionDetail,
  });
}

final class CommisionHistoryDetailError extends CommisionHistoryDetailState {
  final String error;

  CommisionHistoryDetailError({required this.error});
}
