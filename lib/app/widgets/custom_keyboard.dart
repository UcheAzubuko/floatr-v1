import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:provider/provider.dart';

import 'app_text.dart';

class CustomKeyboard extends StatelessWidget {
  const CustomKeyboard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var keyboardProvider = context.read<KeyboardProvider>();

    return SizedBox(
      // color: Colors.red,
      height: context.heightPx * 0.32,
      width: context.widthPx,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // 1
              KeyboardKey(
                onTap: () => keyboardProvider.compose('1'),
                keyValue: '1',
              ),

              // 2
              KeyboardKey(
                onTap: () => keyboardProvider.compose('2'),
                keyValue: '2',
              ),

              // 3
              KeyboardKey(
                onTap: () => keyboardProvider.compose('3'),
                keyValue: '3',
              ),
            ],
          ),

          // 4 5 6
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // 1
              KeyboardKey(
                onTap: () => keyboardProvider.compose('4'),
                keyValue: '4',
              ),

              // 2
              KeyboardKey(
                onTap: () => keyboardProvider.compose('5'),
                keyValue: '5',
              ),

              // 3
              KeyboardKey(
                onTap: () => keyboardProvider.compose('6'),
                keyValue: '6',
              ),
            ],
          ),

          // 7 8 9
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // 7
              KeyboardKey(
                onTap: () => keyboardProvider.compose('7'),
                keyValue: '7',
              ),

              // 8
              KeyboardKey(
                onTap: () => keyboardProvider.compose('8'),
                keyValue: '8',
              ),

              // 9
              KeyboardKey(
                onTap: () => keyboardProvider.compose('9'),
                keyValue: '9',
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // #
              KeyboardKey(
                onTap: () => keyboardProvider.compose('#'),
                keyValue: '#',
              ),

              // 0
              KeyboardKey(
                onTap: () => keyboardProvider.compose('0'),
                keyValue: '0',
              ),

              // *
              KeyboardKey(
                onTap: () => keyboardProvider.clearAll(),
                keyValue: '*',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class KeyboardKey extends StatelessWidget {
  final Function onTap;
  final String keyValue;

  // ignore: use_key_in_widget_constructors
  const KeyboardKey({required this.onTap, required this.keyValue});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: AppColors.primaryColor.withOpacity(0.2),
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      onTap: () => onTap(),
      child: SizedBox(
        width: context.widthPx * 0.1,
        child: Center(
          child: AppText(
            text: keyValue,
            fontWeight: FontWeight.w500,
            size: context.widthPx * 0.075,
          ),
        ),
      ),
    );
  }
}

class KeyboardProvider with ChangeNotifier {
  final List<String> _inputs = [];

  OtpFieldController _otpFieldController = OtpFieldController();
  OtpFieldController get controller => _otpFieldController;

  // UnmodifiableListView<String> get inputs => UnmodifiableListView(_inputs);

  updateController(OtpFieldController otpFieldController) {
    _otpFieldController = otpFieldController;
    notifyListeners();
  }

  // void updateInputs(List<String> inputs) {
  //   _inputs = inputs;
  //   print(_inputs);
  //   notifyListeners();
  // }
  void clearAll() {
    _inputs.clear();
    _otpFieldController.clear();
  }

  void compose(String keyInput) {
    // updateInputs(_inputs..add(keyInput));
    // print(keyInput);
    _inputs.add(keyInput);

    updateController(_otpFieldController
      ..setValue(keyInput, _inputs.length - 1)
      ..setFocus(_inputs.length == 4 ? 3 : _inputs.length));
  }
}
