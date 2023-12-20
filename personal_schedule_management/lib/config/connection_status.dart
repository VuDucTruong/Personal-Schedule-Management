import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:personal_schedule_management/features/widgets/stateless/no_internet_widget.dart';

// final InternetConnectionChecker connectionCheckerInstance =
// InternetConnectionChecker.createInstance(
//   checkTimeout: const Duration(seconds: 1),
//   checkInterval: const Duration(seconds: 1),
// );
//
// final StreamSubscription<InternetConnectionStatus> listener =
// InternetConnectionChecker().onStatusChange.listen(
//       (InternetConnectionStatus status) {
//     switch (status) {
//       case InternetConnectionStatus.connected:
//         break;
//       case InternetConnectionStatus.disconnected:
//       // ignore: avoid_print
//         print('You are disconnected from the internet.');
//         break;
//     }
//   },
// );

class ConnectionStatus {
  static ConnectionStatus? _instance;
  BuildContext _context;
  static instance () => _instance;
  BuildContext context () => _context;

  ConnectionStatus(
    this._context
  );

  void newContext(BuildContext context) {
    _context = context;
    listener.resume();
  }

  static createInstance(BuildContext context){
    if (_instance == null){
      _instance = ConnectionStatus(context);
      listener.resume();
    }
    else
    {
      _instance?.newContext(context);
      listener.resume();
    }
  }

  static void dispose(){
    _instance = null;
    listener.pause();
  }

  final InternetConnectionChecker connectionCheckerInstance =
  InternetConnectionChecker.createInstance(
    checkTimeout: const Duration(seconds: 1),
    checkInterval: const Duration(seconds: 1),
  );

  static StreamSubscription<InternetConnectionStatus> listener =
  InternetConnectionChecker().onStatusChange.listen(
        (InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          print('Connected.');
          break;
        case InternetConnectionStatus.disconnected:
        // ignore: avoid_print
          print('Disconnected.');
          if (instance().context() != null){
            Navigator.of(instance().context(), rootNavigator: true).pushAndRemoveUntil(
                _createRoute(), (route) => false);
            break;
          }
      }
    },
  );

  // CHANGE PAGE ANIMATION
  static Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
      NoInternetWidget(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }
}