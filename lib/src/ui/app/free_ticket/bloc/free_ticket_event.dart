part of 'free_ticket_bloc.dart';

@immutable
sealed class FreeTicketEvent extends AStateEvent {}

final class FreeTicketInitialEvent extends FreeTicketEvent {}
