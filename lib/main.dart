import 'package:floatr/core/misc/provider_registry.dart';
import 'package:floatr/core/route/navigation_service.dart';
import 'package:floatr/core/utils/app_colors.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:provider/provider.dart';

import 'core/misc/dependency_injectors.dart';
import 'core/route/router.dart';
import 'core/utils/app_style.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: globalProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Floatr',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.backgroundColor,
          useMaterial3: false,
          textTheme: TextThemes.plusJakartaSansTextTheme,
          // primarySwatch: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
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
      ),
    );
  }
}
