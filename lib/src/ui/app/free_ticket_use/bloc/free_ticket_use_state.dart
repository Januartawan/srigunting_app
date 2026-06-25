part of 'free_ticket_use_bloc.dart';

@immutable
sealed class FreeTicketUseState extends AState {}

final class FreeTicketUseInitial extends FreeTicketUseState {}

final class FreeTicketUseSubmitLoading extends FreeTicketUseState {}

final class FreeTicketUseSubmitSuccess extends FreeTicketUseState {
  final FreeVisit freeVisit;

  FreeTicketUseSubmitSuccess({required this.freeVisit});
}

final class FreeTicketUseSubmitError extends FreeTicketUseState {
  final String error;

  FreeTicketUseSubmitError({required this.error});
}
