import 'package:srigunting_app/src/domain/feedback.dart';
import 'package:srigunting_app/src/repository/api_url/api_url.dart';
import 'package:srigunting_app/src/repository/api_url/base_remote.dart';
import 'package:srigunting_app/src/repository/feedback_repository.dart';
import 'package:srigunting_app/src/repository/rest/tool/result.dart';

class FeedbackRestRepository extends BaseRemote implements FeedbackRepository {
  FeedbackRestRepository(super.dio);

  @override
  Future<Result<Feedback>> fetchFeedback() async {
    var result = await getMethod<Feedback>(
      ApiUrl.FEEDBACK,
      headers: const {'Accept': 'application/json'},
      converter: ((response) {
        if (response is! Map || response['data'] is! Map) {
          throw Exception(response is Map
              ? response['message'] ?? 'Data feedback tidak valid'
              : 'Data feedback tidak valid');
        }

        return Feedback.fromJson(
          Map<String, dynamic>.from(response['data']),
        );
      }),
    );
    return result;
  }

  @override
  Future<Result<bool>> storeFeedback(Feedback feedback) async {
    var result = await postMethod<bool>(
      ApiUrl.FEEDBACK_STORE,
      headers: const {'Accept': 'application/json'},
      body: feedback.toStoreJson(),
      converter: ((response) => true),
    );
    return result;
  }
}
