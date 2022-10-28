import 'dart:async';

import 'package:floatr/app/features/onboarding/onboarding_screen_main.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // startSplashScreenTimer() async {
  //   var _duration = new Duration(seconds: 5);
  //   return new Timer(_duration, navigateToPage);
  // }

  // void navigateToPage() {
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => const OnboardingScreen(),
  //     ),
  //   );
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   startSplashScreenTimer();
  // }
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 4),
      (() {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const OnboardingScreen(),
          ),
        );
      }),
    );
  }

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..forward();

  late final Animation<Offset> _leftToRightAnim = Tween<Offset>(
    begin: const Offset(-1.5, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

  late final Animation<Offset> _rightToLeftAnim =
      Tween<Offset>(begin: const Offset(1.5, 0.0), end: Offset.zero).animate(
    CurvedAnimation(parent: _controller, curve: Curves.easeIn),
  );

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode([]);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(),
      child: Center(
        child: SvgPicture.asset(
          'assets/images/onboarding1.svg',
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
