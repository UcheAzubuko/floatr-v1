import 'package:floatr/core/route/router.dart';
import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  pop() {
    return _navigationKey.currentState!.pop();
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateReplacementTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushAndRemoveUntil<T extends dynamic>(String newRoute) {
    return _navigationKey.currentState!
        .pushNamedAndRemoveUntil(newRoute, (Route<dynamic> route) => false);
  }

  /// Pass in the widget to route to directly
  Future<dynamic> navigateToRoute(Widget route) {
    return _navigationKey.currentState!.push(slidePageTransition(route));
  }

  Future<dynamic> maybePop() {
    return _navigationKey.currentState!.maybePop();
  }
}
