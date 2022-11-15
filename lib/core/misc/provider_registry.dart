import 'package:floatr/app/features/authentication/providers/authentication_provider.dart';
import 'package:floatr/app/widgets/custom_keyboard.dart';
import 'package:provider/provider.dart';

import 'dependency_injectors.dart';

final globalProviders = [
  ChangeNotifierProvider(create: (_) => KeyboardProvider()),
  ChangeNotifierProvider(create: (_) => AuthenticationProvider(authenticationRepository: di())),
];
