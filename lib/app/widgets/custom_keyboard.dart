// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:provider/provider.dart';

import 'app_text.dart';

class CustomKeyboard extends StatefulWidget {
  const CustomKeyboard({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomKeyboard> createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {
  // clear keyboardProvider state
  @override
  void deactivate() {
    context.read<KeyboardProvider>().inputs.clear();
    super.deactivate();
  }

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
                customizeKey: true,
              ),

              // 0
              KeyboardKey(
                onTap: () => keyboardProvider.compose('0'),
                keyValue: '0',
              ),

              // clear
              KeyboardKey(
                onTap: () {
                  if (keyboardProvider._isControllerDeactivated) {
                    keyboardProvider.clearKeys();
                  } else {
                    keyboardProvider
                      ..clearController()
                      ..clearKeys();
                  }
                },
                keyValue: '*',
                customizeKey: true,
                widget: SizedBox(
                  width: context.widthPx * 0.1,
                  child: SvgPicture.asset('assets/icons/outline/clear.svg'),
                ),
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
  final bool customizeKey;
  final Widget widget;

  // ignore: use_key_in_widget_constructors
  const KeyboardKey(
      {required this.onTap,
      required this.keyValue,
      this.customizeKey = false,
      this.widget = const SizedBox(width: 10)});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: AppColors.primaryColor.withOpacity(0.2),
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      onTap: () => onTap(),
      child: SizedBox(
        width: context.widthPx * 0.1,
        height: context.heightPx * 0.05,
        child: Center(
          child: customizeKey
              ? widget
              : AppText(
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
  // KeyboardProvider(
  //     {required int requiredLength, bool isControllerDeactivated = false})
  //     : _requiredLength = requiredLength,
  //       _isControllerDeactivated = isControllerDeactivated;

  final List<String> _inputs = [];
  int _requiredLength = 4;
  bool _isControllerDeactivated = false;

  OtpFieldController _otpFieldController = OtpFieldController();
  OtpFieldController get controller => _otpFieldController;
  bool _isFilled = false;
  bool get isFilled => _isFilled;

  List<String> get inputs {
    print(_inputs.length);
    return _inputs;
  }

  updateRequiredLength(int requiredLength) {
    _requiredLength = requiredLength;
    notifyListeners();
  }

  /// Pass a bool to activate/deactivate controller
  updateControllerActiveStatus(bool deactivateController) {
    _isControllerDeactivated = deactivateController;
    notifyListeners();
  }

  updateController(OtpFieldController otpFieldController) {
    _otpFieldController = otpFieldController;
    notifyListeners();
  }

  updateFilled(bool isFilled) {
    _isFilled = isFilled;
    notifyListeners();
  }

  // void updateInputs(List<String> inputs) {
  //   _inputs = inputs;
  //   print(_inputs);
  //   notifyListeners();
  // }
  void clearKeys() {
    _inputs.clear();
    updateFilled(false);
    notifyListeners();
    // _otpFieldController.clear();
  }

  void clearController() {
    _otpFieldController.clear();
  }

  /// construct keys
  void compose(String keyInput) {
    if (_inputs.length < _requiredLength) {
      _inputs.add(keyInput);
      _isControllerDeactivated
          ? log('Controller is Deactivated: This is not warning, please ignore')
          : updateController(_otpFieldController
            ..setValue(keyInput, _inputs.length - 1)
            ..setFocus(_inputs.length == _requiredLength
                ? _requiredLength - 1
                : _inputs.length));

      _inputs.length < _requiredLength
          ? log('Fields not yet filled')
          : _isControllerDeactivated
              ? updateFilled(_inputs.length == _requiredLength)
              : _otpFieldController.set(_inputs);
      print(_inputs);
      notifyListeners();
    }
  }
}
