import 'package:floatr/app/features/authentication/providers/authentication_provider.dart';
import 'package:floatr/app/features/camera/camera_provider.dart';
import 'package:floatr/app/features/profile/providers/user_profile_provider.dart';
import 'package:floatr/app/features/profile/providers/user_resources_provider.dart';
import 'package:floatr/core/providers/base_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'dependency_injectors.dart';

final globalProviders = <SingleChildWidget>[
  ChangeNotifierProvider(create: (_) => BaseProvider()),
  // ChangeNotifierProvider(create: (_) => KeyboardProvider()),
  ChangeNotifierProvider(create: (_) => CameraProvider()),
  
  ChangeNotifierProvider(create: (_) => AuthenticationProvider(authenticationRepository: di())),
  ChangeNotifierProvider(create: (_) => UserResourcesProvider(userResourcesRepository: di())),
  ChangeNotifierProvider(create: (_) => UserProfileProvider(profileRepository: di())),
];
