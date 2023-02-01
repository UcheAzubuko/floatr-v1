class VerifyBankParams {
  final String bankAccountNumber;
  final String bankId;
  final String processor;

  VerifyBankParams({
    required this.bankAccountNumber,
    required this.bankId,
    required this.processor,
  });

  Map<String, dynamic> toMap() => {
        "bankAccountNumber": bankAccountNumber,
        "bankId": bankId,
        "processor": processor,
      };
}
