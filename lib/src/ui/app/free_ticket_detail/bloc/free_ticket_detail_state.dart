part of 'free_ticket_detail_bloc.dart';

@immutable
sealed class FreeTicketDetailState extends AState {}

final class FreeTicketDetailInitial extends FreeTicketDetailState {}

final class FreeTicketDetailInitialLoading extends FreeTicketDetailState {}

final class FreeTicketDetailInitialError extends FreeTicketDetailState {
  final String error;

  FreeTicketDetailInitialError({required this.error});
}

final class FreeTicketDetailInitiaSuccess extends FreeTicketDetailState {
  final String guideCode;

  FreeTicketDetailInitiaSuccess({required this.guideCode});
}
