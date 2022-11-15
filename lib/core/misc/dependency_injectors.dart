import 'package:floatr/app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:get_it/get_it.dart';

import '../route/navigation_service.dart';

GetIt di = GetIt.instance;

Future<void> setupLocator() async {
  // providers

  // data

  // repos
  di.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepository());

  // services

  // external

  // core
  di.registerLazySingleton(() => NavigationService());
}
