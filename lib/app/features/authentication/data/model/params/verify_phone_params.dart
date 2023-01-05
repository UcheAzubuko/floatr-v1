class VerifyPhoneParams {
  String? token;

  VerifyPhoneParams({
    required this.token,
  });

  Map<String, String?> toMap() {
    return {
      "token": token,
    };
  }
}
