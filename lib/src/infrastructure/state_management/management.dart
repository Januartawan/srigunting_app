import 'package:srigunting_app/src/infrastructure/state_management/event.dart';
import 'package:srigunting_app/src/infrastructure/state_management/state.dart';

abstract class AStateManagement<AE extends AStateEvent, AS extends AState> {
  void emit(AS state);
  Stream<AS> get stateStream;
  T? getStates<T extends AS>();

  void pushEvent(AE event);
}
