import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import 'package:animated_splash_screen/animated_splash_screen.dart';
import "package:personal_schedule_management/main.dart";
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: AnimatedSplashScreen(
      duration: 2000,
      splash: Image.asset('assets/image/logo.jpg'),
      nextScreen: MyApp(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
    ));
  }
}
