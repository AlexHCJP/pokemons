import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class BlocObserverLogger implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log('Bloc ${bloc.toString()} ${change.currentState} => ${change.nextState}');
  }

  @override
  void onClose(BlocBase bloc) {
    log('Bloc ${bloc.toString()} closed');

  }

  @override
  void onCreate(BlocBase bloc) {
    log('Bloc ${bloc.toString()} created');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('Bloc ${bloc.toString()} error');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    log('Bloc ${bloc.toString()} ${event.toString()}');

  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log('Bloc ${bloc.toString()} ${transition.event}: ${transition.currentState} -> ${transition.nextState}');
  }
}
