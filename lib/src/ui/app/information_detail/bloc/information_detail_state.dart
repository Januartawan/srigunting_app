part of 'information_detail_bloc.dart';

@immutable
sealed class InformationDetailState extends AState {}

final class InformationDetailInitial extends InformationDetailState {}

final class InformationDetailInitialLoaded extends InformationDetailState {
  final Information dataInformation;

  InformationDetailInitialLoaded({required this.dataInformation});
}

final class InformationDetailInitialLoading extends InformationDetailState {}

final class InformationDetailInitialError extends InformationDetailState {
  final String error;

  InformationDetailInitialError({required this.error});
}
