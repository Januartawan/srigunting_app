part of 'free_visit_detail_bloc.dart';

@immutable
sealed class FreeVisitDetailState extends AState {}

final class FreeVisitDetailInitial extends FreeVisitDetailState {}

final class FreeVisitDetailLoading extends FreeVisitDetailState {}

final class FreeVisitDetailLoaded extends FreeVisitDetailState {
  final FreeVisit dataVisit;

  FreeVisitDetailLoaded({required this.dataVisit});
}

final class FreeVisitDetailError extends FreeVisitDetailState {
  final String error;

  FreeVisitDetailError({required this.error});
}
