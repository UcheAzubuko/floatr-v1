import 'package:floatr/app/features/authentication/view/biometrics_screen.dart';
import 'package:floatr/app/features/authentication/view/confirm_details_screen.dart';
import 'package:floatr/app/features/authentication/view/create_pin_screen.dart';
import 'package:floatr/app/features/authentication/view/login_screen.dart';
import 'package:floatr/app/features/authentication/view/sign_up_screen.dart';
import 'package:floatr/app/features/authentication/view/take_selfie_screen.dart';
import 'package:floatr/app/features/authentication/view/verify_bvn_screen.dart';
import 'package:floatr/app/features/authentication/view/verify_otp_screen.dart';
import 'package:floatr/app/features/onboarding/post_onboarding.dart';
import 'package:floatr/app/features/onboarding/splash_screen.dart';
import 'package:floatr/core/route/route_names.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteName.postOnboarding:
        return MaterialPageRoute(builder: (_) => const PostOnboarding());
      case RouteName.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteName.signup:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case RouteName.verifyOTP:
        return MaterialPageRoute(builder: (_) => const VerifyPhoneScreen());
      case RouteName.verifyBVN:
        return MaterialPageRoute(builder: (_) => const VerifyBVNScreen());
      case RouteName.takeSelfie:
        return MaterialPageRoute(builder: (_) => const TakeSelefieScreen());
      case RouteName.confirmDetails:
        return MaterialPageRoute(builder: (_) => const ConfirmDetailsScreen());
      case RouteName.createPin:
        return MaterialPageRoute(builder: (_) => const CreatePinScreen());
      case RouteName.biometrics:
        return MaterialPageRoute(builder: (_) => const BiometricsScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
