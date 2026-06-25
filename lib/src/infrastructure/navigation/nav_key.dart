import 'package:flutter/material.dart';

class NavigationService {
  static final NavigationService instance = NavigationService._internal();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigationService._internal();

  Future<void> navigateTo(String routeName) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
          routeName,
          (route) => route.isFirst,
        ) ??
        Future.value();
  }

  void goBack() {
    return navigatorKey.currentState?.pop();
  }
}
