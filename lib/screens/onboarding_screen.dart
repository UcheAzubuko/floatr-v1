import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../utils/theme_config.dart';
import '../screens/onboarding_screens/onboarding_screen_one.dart';
import '../screens/onboarding_screens/onboarding_screen_three.dart';
import '../screens/onboarding_screens/onboarding_screen_two.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Controller to keep track of current page
  final PageController _pageController = PageController();
  // final bool _onLastOnboardingScreen = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: const <Widget>[
              OnboardingScreenOne(),
              OnboardingScreenTwo(),
              OnboardingScreenThree(),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                horizontal: (27 / 360) * screenWidth,
                vertical: (77 / 800) * screenHeight),
            alignment: const Alignment(-1, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    spacing: (12 / 360) * screenWidth,
                    radius: (5 / 360) * screenWidth,
                    dotHeight: (10 / 800) * screenHeight,
                    dotWidth: (24 / 800) * screenWidth,
                    activeDotColor: AppTheme.primaryColor,
                    dotColor: const Color.fromRGBO(247, 223, 212, 1),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: (40 / 800) * screenHeight,
                      width: (40 / 360) * screenWidth,
                      color: AppTheme.primaryColor,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/icons/outline/arrow-right.svg',
                        semanticsLabel: 'arrow_right',
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
