part of 'pricelist_program_bloc.dart';

@immutable
sealed class PricelistProgramEvent extends AStateEvent {}

final class PricelistProgramInitialEvent extends PricelistProgramEvent {}
