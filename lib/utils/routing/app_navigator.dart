import 'package:flutter/material.dart';

class AppNavigator {
  static final GlobalKey<NavigatorState> _rootNavigator =
      GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> get rootKey => _rootNavigator;

  static NavigatorState? get currentState => _rootNavigator.currentState;

  static BuildContext? get currentContext => _rootNavigator.currentContext;
}
