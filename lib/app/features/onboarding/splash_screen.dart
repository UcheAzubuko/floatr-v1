import 'package:floatr/app/features/authentication/providers/authentication_provider.dart';
import 'package:floatr/app/widgets/app_snackbar.dart';
import 'package:floatr/core/providers/base_provider.dart';
import 'package:floatr/core/route/route_names.dart';
import 'package:floatr/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../app/extensions/sized_context.dart';
import '../../../core/misc/dependency_injectors.dart';
import '../../../core/route/navigation_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  // int splashtime = 15;
  // duration of splash screen on second

  @override
  void initState() {
    final auth = context.read<AuthenticationProvider>();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => auth.getUser().then((_) {
              Future.delayed(const Duration(seconds: 1), () async {
                if (auth.loadingState == LoadingState.error) {
                  if (!auth.isLoggedIn) {
                    di<NavigationService>().navigateTo(RouteName.onBoarding);
                  } else {
                    AppSnackBar.showErrorSnackBar(
                        context, auth.errorMsg, const Duration(minutes: 2));
                  }
                } else if (auth.loadingState == LoadingState.loaded) {
                  di<NavigationService>().navigateTo(RouteName.onBoarding);
                }
              });
            }));

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
