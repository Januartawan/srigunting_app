part of 'reward_and_point_detail_bloc.dart';

@immutable
sealed class RewardAndPointDetailEvent extends AStateEvent {}

final class RewardAndPointDetailInitialEvent
    extends RewardAndPointDetailEvent {}
