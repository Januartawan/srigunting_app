part of 'commision_history_bloc.dart';

@immutable
sealed class CommisionHistoryEvent extends AStateEvent {}

final class CommisionHistoryInitialEvent extends CommisionHistoryEvent {}

final class CommisionHistoryLoadMoreEvent extends CommisionHistoryEvent {
  final int page;
  CommisionHistoryLoadMoreEvent({required this.page});
}
