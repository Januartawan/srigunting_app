part of 'reward_and_point_detail_bloc.dart';

@immutable
sealed class RewardAndPointDetailState extends AState {}

final class RewardAndPointDetailInitial extends RewardAndPointDetailState {}

final class RewardAndPointDetailLoading extends RewardAndPointDetailState {}

final class RewardAndPointDetailLoaded extends RewardAndPointDetailState {
  final Transaction dataTransaction;

  RewardAndPointDetailLoaded({required this.dataTransaction});
}

final class RewardAndPointDetailError extends RewardAndPointDetailState {
  final String error;

  RewardAndPointDetailError({required this.error});
}
