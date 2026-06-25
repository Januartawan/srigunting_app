import 'package:flutter/foundation.dart';
import 'package:srigunting_app/src/domain/feedback.dart';
import 'package:srigunting_app/src/infrastructure/state_management/bloc/bloc_state.dart';
import 'package:srigunting_app/src/infrastructure/state_management/event.dart';
import 'package:srigunting_app/src/infrastructure/state_management/state.dart';
import 'package:srigunting_app/src/repository/feedback_repository.dart';
import 'package:srigunting_app/src/repository/rest/tool/network_func.dart';

part 'feedback_event.dart';
part 'feedback_state.dart';

class FeedbackBloc extends ABlocManagement<FeedbackEvent, FeedbackState> {
  final FeedbackRepository _feedbackRepository;

  FeedbackBloc(this._feedbackRepository) : super(FeedbackInitial()) {
    on<FeedbackInitialEvent>((event, emit) async {
      try {
        emit(FeedbackInitialLoading());

        var res = await _feedbackRepository.fetchFeedback();

        responseHandler<Feedback>(res, onSuccess: (response) {
          emit(FeedbackInitialLoaded(feedback: response ?? Feedback()));
        }, onError: (dioError, code, errorMessage) {
          emit(FeedbackInitialError(error: errorMessage));
        });
      } catch (e) {
        emit(FeedbackInitialError(error: e.toString()));
      }
    });

    on<FeedbackSubmitEvent>((event, emit) async {
      try {
        emit(FeedbackSubmitLoading());

        var res = await _feedbackRepository.storeFeedback(event.feedback);

        responseHandler<bool>(res, onSuccess: (response) {
          emit(FeedbackSubmitSuccess());
        }, onError: (dioError, code, errorMessage) {
          emit(FeedbackSubmitError(error: errorMessage));
        });
      } catch (e) {
        emit(FeedbackSubmitError(error: e.toString()));
      }
    });
  }
}
