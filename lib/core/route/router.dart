import 'package:floatr/app/features/authentication/view/biometrics_screen.dart';
import 'package:floatr/app/features/authentication/view/confirm_details_screen.dart';
import 'package:floatr/app/features/authentication/view/create_pin_screen.dart';
import 'package:floatr/app/features/authentication/view/display_picture_screen.dart';
import 'package:floatr/app/features/authentication/view/forgot_password_screen.dart';
import 'package:floatr/app/features/authentication/view/forgot_password_otp_screen.dart';
import 'package:floatr/app/features/authentication/view/login_screen.dart';
import 'package:floatr/app/features/authentication/view/reset_password_screen.dart';
import 'package:floatr/app/features/authentication/view/sign_up_screen.dart';
import 'package:floatr/app/features/authentication/view/take_selfie_screen.dart';
import 'package:floatr/app/features/authentication/view/verify_bvn_screen.dart';
import 'package:floatr/app/features/authentication/view/verify_otp_screen.dart';
import 'package:floatr/app/features/dashboard/view/dashboard_loan_details.dart';
import 'package:floatr/app/features/dashboard/view/dashboard_screen.dart';
import 'package:floatr/app/features/loan/view/screens/loan_info_screen.dart';
import 'package:floatr/app/features/onboarding/onboarding_screen_main.dart';
import 'package:floatr/app/features/onboarding/post_onboarding.dart';
import 'package:floatr/app/features/onboarding/splash_screen.dart';
import 'package:floatr/app/features/profile/view/screens/edit_profile.dart';
import 'package:floatr/app/features/profile/view/screens/profile_screen.dart';
import 'package:floatr/app/features/profile/view/screens/profile_views/cards_banks_screen.dart';
import 'package:floatr/app/features/profile/view/screens/snap_document_screen.dart';
import 'package:floatr/core/route/route_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/features/authentication/providers/authentication_provider.dart';
import '../../app/widgets/bottom_navbar.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteName.postOnboarding:
        return MaterialPageRoute(builder: (_) => const PostOnboarding());
      case RouteName.onBoarding:
        return MaterialPageRoute(builder: (_) {
          final auth = _.read<AuthenticationProvider>();
          return auth.isLoggedIn
              ? const BottomNavigation()
              : const OnboardingScreen();
        });
      case RouteName.login:
        return slidePageTransition(const LoginScreen());
      case RouteName.signup:
        return slidePageTransition(const SignUpScreen());
      case RouteName.verifyOTP:
        return slidePageTransition(const VerifyPhoneScreen());
      case RouteName.verifyBVN:
        return slidePageTransition(const VerifyBVNScreen());
      case RouteName.takeSelfie:
        return slidePageTransition(const TakeSelefieScreen());
        case RouteName.cardsBanks:
        final args = settings.arguments as CardsBanksArguments;
        return slidePageTransition(CardsBanksScreen(togglePosition: args.togglePosition,));
      case RouteName.confirmDetails:
        return slidePageTransition(const ConfirmDetailsScreen());
      case RouteName.createPin:
        return MaterialPageRoute(builder: (_) => const CreatePinScreen());
      case RouteName.displayPicture:
        final args = settings.arguments as DisplayImageArguments;
        return slidePageTransition(
          DisplayPictureScreen(
            image: args.file,
            imageType: args.imageType,
          ),
        );
      case RouteName.biometrics:
        return MaterialPageRoute(builder: (_) => const BiometricsScreen());
      case RouteName.dashboardLoanDueTime:
        final args = settings.arguments as DashboardLoanDetailsArguments;
        return slidePageTransition(
            DashoardLoanDetails(dashboardLoanView: args.dashboardLoanView));
      case RouteName.editProfile:
        final args = settings.arguments as EditProfileArguments;
        return slidePageTransition(EditProfileScreen(
          editProfileView: args.editProfileView,
        ));
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
        return slidePageTransition(const ProfileScreen());
      case RouteName.snapDocument:
        final args = settings.arguments as SnapDocumentArguments;
        return slidePageTransition(SnapDocumentScreen(
          documentType: args.documentType,
        ));
      case RouteName.navbar:
        return slidePageTransition(const BottomNavigation());
      case RouteName.cards:
        return slidePageTransition(const AddNewBankScreen());
      default:
        return slidePageTransition(const SplashScreen());
    }
  }
}

Route slidePageTransition(Widget screen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.decelerate;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
