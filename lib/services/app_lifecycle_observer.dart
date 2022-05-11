import 'dart:async';

import 'package:flutter/material.dart';

class AppLifecycleObserver extends WidgetsBindingObserver {
  static final AppLifecycleObserver _observer = AppLifecycleObserver._internal();

  AppLifecycleObserver._internal();

  factory AppLifecycleObserver() => _observer;

  final _streamController = StreamController<AppLifecycleState>.broadcast();

  Stream<AppLifecycleState> get status async* {
    yield* _streamController.stream;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
    _streamController.add(state);
  }
}
