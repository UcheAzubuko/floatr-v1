class ResetPasswordParams {
  final String? password;
  final String? phoneNumber;
  final String? token;

  ResetPasswordParams({this.password, this.phoneNumber, this.token});

  Map<String, dynamic> toMap() => {
        "password": password,
        "phoneNumber": phoneNumber,
        "token": token,
      };
}
