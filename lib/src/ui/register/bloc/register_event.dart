part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent extends AStateEvent {}

final class RegisterInitialEvent extends RegisterEvent {}

final class RegisterExecute extends RegisterEvent {
  final RegisterRequest payload;

  RegisterExecute({required this.payload});
}
