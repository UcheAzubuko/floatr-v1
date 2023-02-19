import 'package:flutter/material.dart';

class KeyboardObserver extends WidgetsBindingObserver {
  Function callback;

  KeyboardObserver({required this.callback});

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bool keyboardIsVisible = WidgetsBinding.instance.window.viewInsets.bottom > 0;
    if (keyboardIsVisible) {
      callback();
    }
  }
}