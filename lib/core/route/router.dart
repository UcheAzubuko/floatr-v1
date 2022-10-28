import 'package:floatr/app/features/authentication/view/login_screen.dart';
import 'package:floatr/app/features/authentication/view/sign_up_screen.dart';
import 'package:floatr/app/features/authentication/view/verify_bvn_screen.dart';
import 'package:floatr/app/features/authentication/view/verify_otp_screen.dart';
import 'package:floatr/app/features/onboarding/splash_screen.dart';
import 'package:floatr/core/route/route_names.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteName.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteName.signup:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case RouteName.verifyOTP:
        return MaterialPageRoute(builder: (_) => const VerifyPhoneScreen());
      case RouteName.verifyBVN:
        return MaterialPageRoute(builder: (_) => const VerifyBVNScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
