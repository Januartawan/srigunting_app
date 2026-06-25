part of 'initial_loading_bloc.dart';

@immutable
sealed class InitialLoadingState extends AState {}

final class InitialLoadingInitial extends InitialLoadingState {}

final class InitialHasToken extends InitialLoadingState {}

final class InitialLogin extends InitialLoadingState {}
