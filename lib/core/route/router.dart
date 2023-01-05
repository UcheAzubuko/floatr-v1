import 'package:floatr/app/features/authentication/view/biometrics_screen.dart';
import 'package:floatr/app/features/authentication/view/confirm_details_screen.dart';
import 'package:floatr/app/features/authentication/view/create_pin_screen.dart';
import 'package:floatr/app/features/authentication/view/forgot_password_screen.dart';
import 'package:floatr/app/features/authentication/view/forgot_password_otp_screen.dart';
import 'package:floatr/app/features/authentication/view/login_screen.dart';
import 'package:floatr/app/features/authentication/view/reset_password_screen.dart';
import 'package:floatr/app/features/authentication/view/sign_up_screen.dart';
import 'package:floatr/app/features/authentication/view/take_selfie_screen.dart';
import 'package:floatr/app/features/authentication/view/verify_bvn_screen.dart';
import 'package:floatr/app/features/authentication/view/verify_otp_screen.dart';
import 'package:floatr/app/features/dashboard/view/dashboard_screen.dart';
import 'package:floatr/app/features/loan/view/screens/loan_info_screen.dart';
import 'package:floatr/app/features/onboarding/post_onboarding.dart';
import 'package:floatr/app/features/onboarding/splash_screen.dart';
import 'package:floatr/app/features/profile/view/screens/profile_screen.dart';
import 'package:floatr/app/features/profile/view/screens/snap_document_screen.dart';
import 'package:floatr/core/route/route_names.dart';
import 'package:flutter/material.dart';

import '../../app/widgets/bottom_navbar.dart';

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
      case RouteName.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case RouteName.forgotPasswordOtp:
        return MaterialPageRoute(
            builder: (_) => const ForgotPasswordOtpScreen());
      case RouteName.resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
      case RouteName.dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case RouteName.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case RouteName.snapDocument:
        return MaterialPageRoute(builder: (_) => const SnapDocumentScreen());
      case RouteName.navbar:
        return MaterialPageRoute(builder: (_) => const BottomNavigation());
      case RouteName.cards:
        return MaterialPageRoute(builder: (_) => const AddNewBankScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
