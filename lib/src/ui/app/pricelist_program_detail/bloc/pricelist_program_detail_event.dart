part of 'pricelist_program_detail_bloc.dart';

@immutable
sealed class PricelistProgramDetailEvent extends AStateEvent {}

final class PricelistProgramDetailInitialEvent
    extends PricelistProgramDetailEvent {
  final String media;

  PricelistProgramDetailInitialEvent({required this.media});
}
