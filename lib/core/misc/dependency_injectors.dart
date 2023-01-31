import 'package:floatr/app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:floatr/app/features/loan/data/repositories/loans_repository.dart';
import 'package:floatr/app/features/profile/data/repositories/profile_repository.dart';
import 'package:floatr/app/features/profile/data/repositories/user_resources_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/services/api_service.dart';
import '../route/navigation_service.dart';

GetIt di = GetIt.instance;

Future<void> setupLocator() async {
  // providers

  // data

  // repos
  di.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepository(prefs: di(), apiService: di()));
  di.registerLazySingleton<UserResourcesRepository>(() => UserResourcesRepository(sharedPreferences: di(), apiService: di()));
  di.registerLazySingleton<ProfileRepository>(() => ProfileRepository(sharedPreferences: di(), apiService: di()));
  di.registerLazySingleton<LoansRepository>(() => LoansRepository(sharedPreferences: di(), apiService: di()));

  // services
  di.registerLazySingleton<APIService>(() => APIService());

  // external
  final sharedPreferences = await SharedPreferences.getInstance();
  di.registerLazySingleton(() => sharedPreferences);

  // core
  di.registerLazySingleton<NavigationService>(() => NavigationService());
}
