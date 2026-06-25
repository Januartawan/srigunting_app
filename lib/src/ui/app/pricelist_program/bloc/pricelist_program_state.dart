part of 'pricelist_program_bloc.dart';

@immutable
sealed class PricelistProgramState extends AState {}

final class PricelistProgramInitial extends PricelistProgramState {}

final class PricelistProgramInitialLoading extends PricelistProgramState {}

final class PricelistProgramInitialLoaded extends PricelistProgramState {
  final List<PricelistProgram> programs;

  PricelistProgramInitialLoaded({required this.programs});
}

final class PricelistProgramInitialError extends PricelistProgramState {
  final String error;

  PricelistProgramInitialError({required this.error});
}
