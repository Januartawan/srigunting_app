part of 'free_ticket_bloc.dart';

@immutable
sealed class FreeTicketState extends AState {}

final class FreeTicketInitial extends FreeTicketState {}

final class FreeTicketLoading extends FreeTicketState {}

final class FreeTicketLoaded extends FreeTicketState {
  final FreeVisit dataVisit;

  FreeTicketLoaded({required this.dataVisit});
}

final class FreeTicketError extends FreeTicketState {
  final String error;

  FreeTicketError({required this.error});
}
