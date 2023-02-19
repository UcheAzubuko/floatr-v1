class ResetPasswordParams {
   String? password;
   String? phoneNumber;
   String? token;

  ResetPasswordParams({this.password, this.phoneNumber, this.token});

  Map<String, dynamic> toMap() => {
        "password": password,
        "phoneNumber": phoneNumber,
        "token": token,
      };
}
