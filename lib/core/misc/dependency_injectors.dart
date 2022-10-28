import 'package:get_it/get_it.dart';

import '../route/navigation_service.dart';

GetIt di = GetIt.instance;

Future<void> setupLocator() async {
  // providers

  // data

  // repos

  // services

  // external

  // core
  di.registerLazySingleton(() => NavigationService());
}
