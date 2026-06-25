part of 'commision_history_detail_bloc.dart';

@immutable
sealed class CommisionHistoryDetailEvent extends AStateEvent {}

final class CommisionHistoryDetailInitialEvent
    extends CommisionHistoryDetailEvent {
  final Transaction transaction;
  final String trxCode;

  CommisionHistoryDetailInitialEvent({
    required this.transaction,
    required this.trxCode,
  });
}
