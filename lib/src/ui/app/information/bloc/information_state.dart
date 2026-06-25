part of 'information_bloc.dart';

@immutable
sealed class InformationState extends AState {}

final class InformationInitial extends InformationState {}

final class InformationInitialLoading extends InformationState {}

final class InformationInitialLoaded extends InformationState {
  final List<Information> dataInformation;
  final Pagination<Information>? pagination;

  InformationInitialLoaded({
    required this.dataInformation,
    this.pagination,
  });
}

final class InformationInitialError extends InformationState {
  final String error;

  InformationInitialError({required this.error});
}

final class InformationLoadMoreLoading extends InformationState {
  final List<Information> dataInformation;
  final Pagination<Information>? pagination;

  InformationLoadMoreLoading({
    required this.dataInformation,
    this.pagination,
  });
}

final class InformationLoadMoreLoaded extends InformationState {
  final List<Information> dataInformation;
  final Pagination<Information>? pagination;

  InformationLoadMoreLoaded({
    required this.dataInformation,
    this.pagination,
  });
}

final class InformationLoadMoreError extends InformationState {
  final String error;
  final List<Information> dataInformation;
  final Pagination<Information>? pagination;

  InformationLoadMoreError({
    required this.error,
    required this.dataInformation,
    this.pagination,
  });
}
