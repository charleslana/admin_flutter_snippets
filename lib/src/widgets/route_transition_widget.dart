import 'package:flutter/material.dart';

class RouteTransitionWidget extends PageRouteBuilder<dynamic> {
  RouteTransitionWidget({
    required this.widget,
    required this.settings,
  }) : super(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return SlideTransition(
              transformHitTests: false,
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(-1, 0),
                ).animate(secondaryAnimation),
                child: child,
              ),
            );
          },
        );

  final Widget widget;
  @override
  final RouteSettings settings;
}
