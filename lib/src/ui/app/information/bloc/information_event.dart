part of 'information_bloc.dart';

@immutable
sealed class InformationEvent extends AStateEvent {}

final class InformationInitialEvent extends InformationEvent {}

final class InformationLoadMoreEvent extends InformationEvent {
  final int page;

  InformationLoadMoreEvent({required this.page});
}
