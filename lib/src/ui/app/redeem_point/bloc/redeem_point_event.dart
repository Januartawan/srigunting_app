part of 'redeem_point_bloc.dart';

@immutable
sealed class RedeemPointEvent extends AStateEvent {}

final class RedeemPointInitialEvent extends RedeemPointEvent {}

final class RedeemPointLoadMoreHistoryEvent extends RedeemPointEvent {
  final int page;
  RedeemPointLoadMoreHistoryEvent({required this.page});
}
