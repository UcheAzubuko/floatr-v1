import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraProvider with ChangeNotifier {
  CameraController? _cameraController;

  CameraController? get cameraController => _cameraController;

  updateController(CameraController? cameraController) {
    log('Controller Set!');
    _cameraController = cameraController;
    notifyListeners();
  }

  @override
  void dispose() {
    _cameraController!.dispose();
    super.dispose();
  }
}
