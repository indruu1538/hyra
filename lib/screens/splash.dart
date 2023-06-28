import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:himi/screens/choose_user.dart';

import 'package:himi/screens/signin_screen.dart';

import '../utils/color_utils.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [


          Image.asset('assets/images/HIRE.png'),
          const Text(
            '',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
           ],
      ),
      backgroundColor: Colors.black,
      nextScreen: const ChooseUser(),
      splashIconSize: 500,
      duration: 4000,
      splashTransition: SplashTransition.fadeTransition,

      animationDuration: const Duration(seconds: 1),
    );
  }
}