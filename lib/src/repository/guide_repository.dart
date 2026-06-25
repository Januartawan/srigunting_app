import 'package:srigunting_app/src/domain/guide.dart';
import 'package:srigunting_app/src/repository/request/register_request.dart';
import 'package:srigunting_app/src/repository/rest/tool/result.dart';

abstract class GuideRepository {
  Future<Result<Guide>> showGuide();
  Future<Result> updateGuide(RegisterRequest payload);
  Future<Result<Guide>> detailAccountSrigunting();
}
