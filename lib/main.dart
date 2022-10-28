// import 'package:flutter/material.dart';

// import '../screens/onboarding_screen.dart';
import 'package:floatr/core/route/navigation_service.dart';
import 'package:flutter/material.dart' hide Router;

import 'app/features/onboarding/splash_screen.dart';
import 'core/misc/dependency_injectors.dart';
import 'core/route/router.dart';
import 'core/utils/theme_config.dart';

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
          scaffoldBackgroundColor: AppTheme.backgroundColor,
          useMaterial3: true,
          // primarySwatch: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.blue),
          ),),
      navigatorKey: di<NavigationService>().navigationKey,
      onGenerateRoute: Router.generateRoute,
      // home: const SplashScreen(),
    );
  }
}
