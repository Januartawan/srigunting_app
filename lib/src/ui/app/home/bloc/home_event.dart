part of 'home_bloc.dart';

@immutable
sealed class HomeEvent extends AStateEvent {}

final class HomeInitialExecute extends HomeEvent {
  final String? deviceToken;
  final String? platform;

  HomeInitialExecute({
    this.deviceToken,
    this.platform,
  });
}
