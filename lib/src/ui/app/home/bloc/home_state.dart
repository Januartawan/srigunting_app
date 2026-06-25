part of 'home_bloc.dart';

@immutable
sealed class HomeState extends AState {}

final class HomeInitial extends HomeState {}

final class HomeInitialLoaded extends HomeState {
  final Guide? dataGuide;
  final Balance? databalance;
  final Balance? dataPointReward;
  final Pagination<Information>? paginationInformation;
  final bool? hasUnreadNotification;

  HomeInitialLoaded({
    this.dataGuide,
    this.databalance,
    this.dataPointReward,
    this.paginationInformation,
    this.hasUnreadNotification,
  });

  HomeInitialLoaded copyWith({
    Guide? dataGuide,
    Balance? databalance,
    Balance? dataPointReward,
    Pagination<Information>? paginationInformation,
    bool? hasUnreadNotification,
  }) =>
      HomeInitialLoaded(
        dataGuide: dataGuide ?? this.dataGuide,
        databalance: databalance ?? this.databalance,
        dataPointReward: dataPointReward ?? this.dataPointReward,
        paginationInformation:
            paginationInformation ?? this.paginationInformation,
        hasUnreadNotification:
            hasUnreadNotification ?? this.hasUnreadNotification,
      );
}

final class HomeInitialLoading extends HomeState {}

final class HomeInitialError extends HomeState {
  final String error;

  HomeInitialError({required this.error});
}
