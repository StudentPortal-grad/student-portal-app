import 'package:flutter/material.dart';
import 'package:student_portal/core/utils/app_router.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  void pop() => Navigator.of(this).pop();
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

BuildContext get currentContext => AppRouter.context!;

Future<dynamic> push(Widget page, {Object? arguments}) {
  return Navigator.of(currentContext)
      .push(MaterialPageRoute(builder: (c) => page));
}

Future<dynamic> pushReplacement(Widget page, {Object? arguments}) {
  return Navigator.of(currentContext)
      .pushReplacement(MaterialPageRoute(builder: (c) => page));
}

pop({Object? result}) => Navigator.pop(currentContext, result);

void popAllAndPushPage(Widget widget, {BuildContext? context}) {
  Navigator.of(context ?? currentContext).pushAndRemoveUntil(
    MaterialPageRoute<dynamic>(builder: (BuildContext context) => widget),
    (Route<dynamic> route) => false,
  );
}
