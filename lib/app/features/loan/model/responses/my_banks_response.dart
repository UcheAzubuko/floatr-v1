import 'dart:convert';

class MyBanksResponse {
  final List<MyBank> mybanks;
  MyBanksResponse({required this.mybanks});

  factory MyBanksResponse.fromJson(List<dynamic> data) => MyBanksResponse(
      mybanks: List<MyBank>.from(data.map((e) => MyBank.fromJson(e))));
}

class MyBank {
  MyBank({
    required this.id,
    required this.uniqueId,
    required this.accountNo,
    required this.accountName,
    required this.userId,
    required this.bankId,
    required this.isActive,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.bank,
  });

  final String id;
  final String uniqueId;
  final String accountNo;
  final String accountName;
  final String userId;
  final String bankId;
  final bool isActive;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final Bank bank;

  factory MyBank.fromRawJson(String str) => MyBank.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyBank.fromJson(Map<String, dynamic> json) => MyBank(
        id: json["id"],
        uniqueId: json["uniqueId"],
        accountNo: json["accountNo"],
        accountName: json["accountName"],
        userId: json["userId"],
        bankId: json["bankId"],
        isActive: json["isActive"],
        isDefault: json["isDefault"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        bank: Bank.fromJson(json["bank"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uniqueId": uniqueId,
        "accountNo": accountNo,
        "accountName": accountName,
        "userId": userId,
        "bankId": bankId,
        "isActive": isActive,
        "isDefault": isDefault,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "bank": bank.toJson(),
      };
}

class Bank {
  Bank({
    required this.name,
    required this.nipBankCode,
    required this.monnifyBankCode,
    required this.baseUssdCode,
    required this.ussdTransferTemplate,
    required this.createdAt,
    required this.updatedAt,
  });

  final String name;
  final dynamic nipBankCode;
  final String monnifyBankCode;
  final String baseUssdCode;
  final String ussdTransferTemplate;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Bank.fromRawJson(String str) => Bank.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        name: json["name"],
        nipBankCode: json["nipBankCode"],
        monnifyBankCode: json["monnifyBankCode"],
        baseUssdCode: json["baseUssdCode"],
        ussdTransferTemplate: json["ussdTransferTemplate"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "nipBankCode": nipBankCode,
        "monnifyBankCode": monnifyBankCode,
        "baseUssdCode": baseUssdCode,
        "ussdTransferTemplate": ussdTransferTemplate,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
