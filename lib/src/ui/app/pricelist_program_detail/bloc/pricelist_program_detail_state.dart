part of 'pricelist_program_detail_bloc.dart';

@immutable
sealed class PricelistProgramDetailState extends AState {}

final class PricelistProgramDetailInitial extends PricelistProgramDetailState {}

final class PricelistProgramDetailInitialLoading
    extends PricelistProgramDetailState {}

final class PricelistProgramDetailInitialLoaded
    extends PricelistProgramDetailState {
  final List<String> imageUrls;

  PricelistProgramDetailInitialLoaded({required this.imageUrls});
}

final class PricelistProgramDetailInitialError
    extends PricelistProgramDetailState {
  final String error;

  PricelistProgramDetailInitialError({required this.error});
}
