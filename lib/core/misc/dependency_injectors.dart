import 'package:floatr/app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../route/navigation_service.dart';

GetIt di = GetIt.instance;

Future<void> setupLocator() async {
  // providers

  // data

  // repos
  di.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepository(prefs: di()));

  // services

  // external
  final sharedPreferences = await SharedPreferences.getInstance();
  di.registerLazySingleton(() => sharedPreferences);

  // core
  di.registerFactory<NavigationService>(() => NavigationService());
}
