part of 'initial_loading_bloc.dart';

@immutable
sealed class InitialLoadingEvent extends AStateEvent {}

final class InitialLoadingExecuteEvent extends InitialLoadingEvent {}
