import 'package:floatr/app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:floatr/app/features/authentication/data/repositories/biometric_repository.dart';
import 'package:floatr/app/features/dashboard/data/repositories/activities_repository.dart';
import 'package:floatr/app/features/loan/data/repositories/loans_repository.dart';
import 'package:floatr/app/features/profile/data/repositories/profile_repository.dart';
import 'package:floatr/app/features/profile/data/repositories/user_resources_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/services/api_service.dart';
import '../route/navigation_service.dart';

GetIt di = GetIt.instance;

Future<void> setupLocator() async {
  // providers

  // data

  // repos
  di.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepository(prefs: di(), apiService: di(), flutterSecureStorage: di()));
  di.registerLazySingleton<UserResourcesRepository>(
      () => UserResourcesRepository(sharedPreferences: di(), apiService: di()));
  di.registerLazySingleton<ProfileRepository>(
      () => ProfileRepository(sharedPreferences: di(), apiService: di()));
  di.registerLazySingleton<LoansRepository>(
      () => LoansRepository(sharedPreferences: di(), apiService: di()));
  di.registerLazySingleton<ActivitiesRepository>(
      () => ActivitiesRepository(sharedPreferences: di(), apiService: di()));
  di.registerLazySingleton<BiometricRepository>(
      () => BiometricRepository(localAuthentication: di()));

  // services
  di.registerLazySingleton<APIService>(() => APIService());

  // external
  final sharedPreferences = await SharedPreferences.getInstance();
  AndroidOptions getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  final secureStorage = FlutterSecureStorage(aOptions: getAndroidOptions());
  di.registerLazySingleton(() => sharedPreferences);
  di.registerLazySingleton(() => secureStorage);
  di.registerLazySingleton(() => LocalAuthentication());

  // core
  di.registerLazySingleton<NavigationService>(() => NavigationService());
}
