class BankParams {
  String bankAccountNumber;
  String bankId;
  String processor;
  String? bankAccountName;

  BankParams({
    required this.bankAccountNumber,
    required this.bankId,
    required this.processor,
    this.bankAccountName,
  });

  Map<String, dynamic> toMap() => {
        "bankAccountNumber": bankAccountNumber,
        "bankId": bankId,
        "processor": processor,
      };
}

class AddBankParams {
  String accountNo;
  String bankId;
  String processor;
  String accountName;

  AddBankParams({
    required this.accountNo,
    required this.bankId,
    required this.processor,
    required this.accountName,
  });

  Map<String, dynamic> toMap() => {
        "accountNo": accountNo,
        "accountName": accountName,
        "bankId": bankId,
        "processor": processor,
      };
}
