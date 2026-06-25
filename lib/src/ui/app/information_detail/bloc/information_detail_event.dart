part of 'information_detail_bloc.dart';

@immutable
sealed class InformationDetailEvent extends AStateEvent {}

final class InformationDetailInitialEvent extends InformationDetailEvent {
  final String slug;

  InformationDetailInitialEvent({required this.slug});
}
