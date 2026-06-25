part of 'notification_bloc.dart';

@immutable
sealed class NotificationState extends AState {}

final class NotificationInitial extends NotificationState {}

final class NotificationInitialLoading extends NotificationState {}

final class NotificationInitialLoaded extends NotificationState {
  final List<NotificationApp> dataNotification;
  final Pagination<NotificationApp>? pagination;

  NotificationInitialLoaded({
    required this.dataNotification,
    this.pagination,
  });
}

final class NotificationInitialError extends NotificationState {
  final String error;

  NotificationInitialError({required this.error});
}

final class NotificationLoadMoreLoading extends NotificationState {
  final List<NotificationApp> dataNotification;
  final Pagination<NotificationApp>? pagination;

  NotificationLoadMoreLoading({
    required this.dataNotification,
    this.pagination,
  });
}

final class NotificationLoadMoreLoaded extends NotificationState {
  final List<NotificationApp> dataNotification;
  final Pagination<NotificationApp>? pagination;

  NotificationLoadMoreLoaded({
    required this.dataNotification,
    this.pagination,
  });
}

final class NotificationLoadMoreError extends NotificationState {
  final String error;
  final List<NotificationApp> dataNotification;
  final Pagination<NotificationApp>? pagination;

  NotificationLoadMoreError({
    required this.error,
    required this.dataNotification,
    this.pagination,
  });
}

final class NotificationShowDetailLoading extends NotificationState {}

final class NotificationShowDetailLoaded extends NotificationState {
  final NotificationApp notification;

  NotificationShowDetailLoaded({required this.notification});
}

final class NotificationShowDetailError extends NotificationState {
  final String error;

  NotificationShowDetailError({required this.error});
}

//SHOW NOTIFICATION TRANSACTION
final class NotificationShowTransactionDetailLoading
    extends NotificationState {}

final class NotificationShowTransactionDetailLoaded extends NotificationState {
  final Transaction notifTransaction;

  NotificationShowTransactionDetailLoaded({required this.notifTransaction});
}

final class NotificationShowTransactionDetailError extends NotificationState {
  final String error;

  NotificationShowTransactionDetailError({required this.error});
}

//SHOW NOTIFICATION FREE VISIT
final class NotificationShowFreeVisitDetailLoading extends NotificationState {}

final class NotificationShowFreeVisitDetailLoaded extends NotificationState {
  final FreeVisit notifFreeVisit;

  NotificationShowFreeVisitDetailLoaded({required this.notifFreeVisit});
}

final class NotificationShowFreeVisitDetailError extends NotificationState {
  final String error;

  NotificationShowFreeVisitDetailError({required this.error});
}
