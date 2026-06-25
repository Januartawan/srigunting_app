part of 'skema_susuk_bloc.dart';

@immutable
sealed class SkemaSusukState extends AState {}

final class SkemaSusukInitial extends SkemaSusukState {}

final class SkemaSusukInitialLoading extends SkemaSusukState {}

final class SkemaSusukInitialLoaded extends SkemaSusukState {
  final List<String> imageUrls;

  SkemaSusukInitialLoaded({required this.imageUrls});
}

final class SkemaSusukInitialError extends SkemaSusukState {
  final String error;

  SkemaSusukInitialError({required this.error});
}
