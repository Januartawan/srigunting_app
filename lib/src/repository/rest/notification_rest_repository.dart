import 'package:srigunting_app/src/domain/free_visit.dart';
import 'package:srigunting_app/src/domain/notification.dart';
import 'package:srigunting_app/src/domain/pagination.dart';
import 'package:srigunting_app/src/domain/transaction.dart';
import 'package:srigunting_app/src/infrastructure/extention/query_param.dart';
import 'package:srigunting_app/src/repository/api_url/api_url.dart';
import 'package:srigunting_app/src/repository/api_url/base_remote.dart';
import 'package:srigunting_app/src/repository/notification_repository.dart';
import 'package:srigunting_app/src/repository/pagination.dart';
import 'package:srigunting_app/src/repository/rest/tool/result.dart';

class NotificationRestRepository extends BaseRemote
    implements NotificationRepository {
  NotificationRestRepository(super.dio);

  @override
  Future<Result<Pagination<NotificationApp>>> fetchNotification(
      PaginationRequest request) async {
    var url = ApiUrl.NOTIFICATION_LIST.queryParam(request.toJson());
    var result = await getMethod(
      url,
      converter: ((response) {
        var meta = response['meta'] ?? response;
        // Jika meta kosong (array atau null), set default meta
        if (meta == null || (meta is List && meta.isEmpty)) {
          meta = {
            "total": 0,
            "current_page": 1,
            "per_page": 10,
            "last_page": 1
          };
        }
        final dataList = List<NotificationApp>.from(
          (response['data'] ?? []).map((x) => NotificationApp.fromJson(x)),
        );
        return Pagination<NotificationApp>.fromJson(meta, dataList);
      }),
    );

    return result;
  }

  @override
  Future<Result<NotificationApp>> showNotification(String slug) async {
    var url = ApiUrl.NOTIFICATION_DETAIL.queryParam({'slug': slug});
    var result = await getMethod(url,
        converter: ((response) => NotificationApp.fromJson(response["data"])));

    return result;
  }

  @override
  Future<Result<FreeVisit>> showNotificationFreeVisit(String slug) async {
    var url = ApiUrl.NOTIFICATION_DETAIL.queryParam({'slug': slug});
    var result = await getMethod(url,
        converter: ((response) => FreeVisit.fromMap(response["data"])));

    return result;
  }

  @override
  Future<Result<Transaction>> showNotificationTransaction(String slug) async {
    var url = ApiUrl.NOTIFICATION_DETAIL.queryParam({'slug': slug});
    var result = await getMethod(url,
        converter: ((response) => Transaction.fromMap(response["data"])));

    return result;
  }
}
