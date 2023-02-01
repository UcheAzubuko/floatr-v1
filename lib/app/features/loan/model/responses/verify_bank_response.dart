class VerifyBankResponse {
  final String accountNo;
  final String accountName;
  final String bankId;

  VerifyBankResponse({
    required this.accountName,
    required this.accountNo,
    required this.bankId,
  });

  factory VerifyBankResponse.fromJson(Map<String, dynamic> json) =>
      VerifyBankResponse(
          accountName: json["accountName"],
          accountNo: json["accountNo"],
          bankId: json["bankId"]);
}
