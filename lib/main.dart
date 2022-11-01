import 'package:floatr/core/route/navigation_service.dart';
import 'package:floatr/core/utils/app_colors.dart';
import 'package:flutter/material.dart' hide Router;

import 'core/misc/dependency_injectors.dart';
import 'core/route/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Floatr',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundColor,
        useMaterial3: false,
        // primarySwatch: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          scrolledUnderElevation: 0,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.primaryColor),
        ),
      ),
      navigatorKey: di<NavigationService>().navigationKey,
      onGenerateRoute: Router.generateRoute,
      // home: const SplashScreen(),
    );
  }
}
