class ChangePasswordParams {
  String? password;
  String? newPassword;
  String? pin;

  ChangePasswordParams({this.password, this.newPassword, this.pin});

  Map<String, dynamic> toMap() =>
      {'password': password, 'newPassword': newPassword, 'pin': pin};
}

class ChangePinParams {
  String? newPin;
  String? pin;

  ChangePinParams({this.newPin, this.pin});

  Map<String, dynamic> toMap() => {'newPin': newPin, 'pin': pin};
}
