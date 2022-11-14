import 'package:floatr/app/widgets/custom_keyboard.dart';
import 'package:provider/provider.dart';

final globalProviders = [
  ChangeNotifierProvider(create: (_) => KeyboardProvider()),
];
