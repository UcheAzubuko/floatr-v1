import 'package:floatr/app/features/onboarding/onboarding_screen_main.dart';
import 'package:floatr/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/extensions/sized_context.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  int splashtime = 3;
  // duration of splash screen on second

  @override
  void initState() {
    Future.delayed(Duration(seconds: splashtime), () async {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          //pushReplacement = replacing the route so that
          //splash screen won't show on back button press
          //navigation to Home page.
          builder: (context) {
            return const OnboardingScreen();
          },
        ),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          //vertically align center
          children: <Widget>[
            SizedBox(
              child: SvgPicture.asset(
                "assets/images/main-logo.svg",
                fit: BoxFit.scaleDown,
                height: context.heightPx * 0.25,
                width: context.widthPx * 0.25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
