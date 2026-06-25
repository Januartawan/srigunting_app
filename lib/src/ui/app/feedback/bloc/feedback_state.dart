part of 'feedback_bloc.dart';

@immutable
sealed class FeedbackState extends AState {}

final class FeedbackInitial extends FeedbackState {}

final class FeedbackInitialLoading extends FeedbackState {}

final class FeedbackInitialLoaded extends FeedbackState {
  final Feedback feedback;

  FeedbackInitialLoaded({required this.feedback});
}

final class FeedbackInitialError extends FeedbackState {
  final String error;

  FeedbackInitialError({required this.error});
}

final class FeedbackSubmitLoading extends FeedbackState {}

final class FeedbackSubmitSuccess extends FeedbackState {}

final class FeedbackSubmitError extends FeedbackState {
  final String error;

  FeedbackSubmitError({required this.error});
}
