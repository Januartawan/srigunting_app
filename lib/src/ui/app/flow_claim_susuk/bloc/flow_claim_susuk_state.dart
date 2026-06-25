part of 'flow_claim_susuk_bloc.dart';

@immutable
sealed class FlowClaimSusukState extends AState {}

final class FlowClaimSusukInitial extends FlowClaimSusukState {}

final class FlowClaimSusukInitialLoading extends FlowClaimSusukState {}

final class FlowClaimSusukInitialLoaded extends FlowClaimSusukState {
  final List<String> imageUrls;

  FlowClaimSusukInitialLoaded({required this.imageUrls});
}

final class FlowClaimSusukInitialError extends FlowClaimSusukState {
  final String error;

  FlowClaimSusukInitialError({required this.error});
}
