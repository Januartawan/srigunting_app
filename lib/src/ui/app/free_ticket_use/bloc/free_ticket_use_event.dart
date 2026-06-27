part of 'free_ticket_use_bloc.dart';

@immutable
sealed class FreeTicketUseEvent extends AStateEvent {}

final class FreeTicketUseSubmitEvent extends FreeTicketUseEvent {
  final FreeTicketRequest request;

  FreeTicketUseSubmitEvent({required this.request});
}
