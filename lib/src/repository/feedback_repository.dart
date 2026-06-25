import 'package:srigunting_app/src/domain/feedback.dart';
import 'package:srigunting_app/src/repository/rest/tool/result.dart';

abstract class FeedbackRepository {
  Future<Result<Feedback>> fetchFeedback();
  Future<Result<bool>> storeFeedback(Feedback feedback);
}
