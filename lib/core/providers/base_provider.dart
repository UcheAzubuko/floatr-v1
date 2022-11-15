import 'package:flutter/material.dart';

class BaseProvider with ChangeNotifier {
  LoadingState _loadingState = LoadingState.idle;

  LoadingState get loadingState => _loadingState;

  String _errorMsg = 'An unknown error occured';

  String get errorMsg => _errorMsg;

  updateLoadingState(LoadingState loadingState) {
    _loadingState = loadingState;
    notifyListeners();
  }

  void disposeState() {
    //
  }

  updateErrorMsgState(String errorMsg) {
    _errorMsg = errorMsg;
    notifyListeners();
  }
}

enum LoadingState {
  idle,
  busy,
  loaded,
  error;
}