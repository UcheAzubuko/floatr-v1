import 'package:floatr/app/features/authentication/providers/authentication_provider.dart';
import 'package:floatr/app/widgets/custom_keyboard.dart';
import 'package:floatr/core/providers/base_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'dependency_injectors.dart';

final globalProviders = <SingleChildWidget>[
  ChangeNotifierProvider(create: (_) => BaseProvider()),
  ChangeNotifierProvider(create: (_) => KeyboardProvider()),
  
  ChangeNotifierProvider(create: (_) => AuthenticationProvider(authenticationRepository: di())),
];
