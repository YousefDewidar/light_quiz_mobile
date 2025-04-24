import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashView extends StatelessWidget {
  final Widget nextView;
  const SplashView({super.key, required this.nextView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: Center(
        child: AnimatedSplashScreen(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          splash: Image.asset(
            "assets/logo_c.png",
            width: MediaQuery.of(context).size.width - 80,
            fit: BoxFit.fitWidth,
          ),
          splashIconSize: MediaQuery.of(context).size.width - 60,
          duration: 300,
          splashTransition: SplashTransition.fadeTransition,
          disableNavigation: false,
          curve: Curves.easeInOut,
          pageTransitionType: PageTransitionType.fade,
          centered: true,
          animationDuration: const Duration(seconds: 2),
          nextScreen: nextView,
        ),
      ),
    );
  }
}
