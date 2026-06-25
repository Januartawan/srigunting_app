part of 'feedback_bloc.dart';

@immutable
sealed class FeedbackEvent extends AStateEvent {}

final class FeedbackInitialEvent extends FeedbackEvent {}

final class FeedbackSubmitEvent extends FeedbackEvent {
  final Feedback feedback;

  FeedbackSubmitEvent({required this.feedback});
}
