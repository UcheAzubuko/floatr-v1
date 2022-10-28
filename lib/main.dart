import 'package:flutter/material.dart';

// import '../screens/onboarding_screen.dart';
import '../screens/onboarding_screens/splash_screen.dart';
import 'utils/theme_config.dart';

void main() {
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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
    );
  }
}
