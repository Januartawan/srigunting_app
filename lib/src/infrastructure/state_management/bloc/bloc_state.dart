import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:srigunting_app/src/infrastructure/state_management/event.dart';
import 'package:srigunting_app/src/infrastructure/state_management/management.dart';
import 'package:srigunting_app/src/infrastructure/state_management/state.dart';

abstract class ABlocManagement<AE extends AStateEvent, AS extends AState>
    extends Bloc<AE, AS> implements AStateManagement<AE, AS> {
  late Emitter<dynamic> emitter;

  ABlocManagement(super.initialState);

  Map<Type, AS> stateMap = {};

  @override
  T? getStates<T extends AS>() {
    try {
      var s = stateMap[T] as T?;
      return s;
    } catch (e) {
      return null;
    }
  }

  @override
  void emitState(AS state) {
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    emit(state);
  }

  @override
  void onChange(Change<AS> change) {
    super.onChange(change);
    // Store the latest state in the map, keyed by its runtime type
    stateMap[change.nextState.runtimeType] = change.nextState;
  }

  @override
  void pushEvent(AE event) {
    add(event);
  }

  @override
  Stream<AS> get stateStream => stream;

  @mustCallSuper
  void dispose() {
    close();
  }

  //debounceSequential cancel other event and replace with new event
  EventTransformer<E> debounceSequential<E>(Duration duration) {
    return (events, mapper) {
      return sequential<E>().call(events.debounceTime(duration), mapper);
    };
  }
}
