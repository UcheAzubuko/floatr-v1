class ChangePasswordParams {
   String? password;
   String? newPassword;
   String? pin;

  ChangePasswordParams(
      { this.password,  this.newPassword,  this.pin});

  Map<String, dynamic> toMap() =>
      {'password': password, 'newPassword': newPassword, 'pin': pin};
}

class ChangePinParams {
  final String newPin;
  final String pin;

  ChangePinParams({required this.newPin, required this.pin});

  Map<String, dynamic> toMap() => {'newPin': newPin, 'pin': pin};
}
