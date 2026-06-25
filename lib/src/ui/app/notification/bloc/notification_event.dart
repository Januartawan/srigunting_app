part of 'notification_bloc.dart';

@immutable
sealed class NotificationEvent extends AStateEvent {}

final class NotificationInitialEvent extends NotificationEvent {}

final class NotificationLoadMoreEvent extends NotificationEvent {
  final int page;

  NotificationLoadMoreEvent({required this.page});
}

final class NotificationShowDetailEvent extends NotificationEvent {
  final String slug;

  NotificationShowDetailEvent({required this.slug});
}

final class NotificationShowDetailTransactionEvent extends NotificationEvent {
  final String slug;

  NotificationShowDetailTransactionEvent({required this.slug});
}

final class NotificationShowDetailFreeVisitEvent extends NotificationEvent {
  final String slug;

  NotificationShowDetailFreeVisitEvent({required this.slug});
}
