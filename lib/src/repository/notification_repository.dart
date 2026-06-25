import 'package:srigunting_app/src/domain/free_visit.dart';
import 'package:srigunting_app/src/domain/notification.dart';
import 'package:srigunting_app/src/domain/pagination.dart';
import 'package:srigunting_app/src/domain/transaction.dart';
import 'package:srigunting_app/src/repository/pagination.dart';
import 'package:srigunting_app/src/repository/rest/tool/result.dart';

abstract class NotificationRepository {
  Future<Result<Pagination<NotificationApp>>> fetchNotification(
      PaginationRequest request);
  Future<Result<NotificationApp>> showNotification(String slug);
  Future<Result<Transaction>> showNotificationTransaction(String slug);
  Future<Result<FreeVisit>> showNotificationFreeVisit(String slug);
}
