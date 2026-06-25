part of 'free_ticket_detail_bloc.dart';

@immutable
sealed class FreeTicketDetailEvent extends AStateEvent {}

final class FreeTicketDetailInitialEvent extends FreeTicketDetailEvent {}
