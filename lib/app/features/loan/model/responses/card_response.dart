import 'dart:convert';

class CardResponse {
  CardResponse({required this.cards});
  final List<Card> cards;

  factory CardResponse.fromJson(List<dynamic> data) =>
      CardResponse(cards: List<Card>.from(data.map((e) => Card.fromJson(e))));
}

class Card {
  Card({
    required this.id,
    required this.uniqueId,
    required this.name,
    required this.processor,
    required this.type,
    required this.panLast4,
    required this.panFirst5,
    required this.maskedPan,
    required this.expiryDate,
    required this.canReuseCard,
    required this.canTokenizeCard,
    required this.userId,
    required this.bankId,
    required this.isActive,
    required this.isDefault,
    required this.meta,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.bank,
  });

  final String id;
  final String uniqueId;
  final String name;
  final String processor;
  final String type;
  final String panLast4;
  final String panFirst5;
  final String maskedPan;
  final DateTime expiryDate;
  final bool canReuseCard;
  final bool canTokenizeCard;
  final String userId;
  final String bankId;
  final bool isActive;
  final bool isDefault;
  final Meta meta;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final Bank bank;

  factory Card.fromRawJson(String str) => Card.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        id: json["id"],
        uniqueId: json["uniqueId"],
        name: json["name"],
        processor: json["processor"],
        type: json["type"],
        panLast4: json["panLast4"],
        panFirst5: json["panFirst5"],
        maskedPan: json["maskedPan"],
        expiryDate: DateTime.parse(json["expiryDate"]),
        canReuseCard: json["canReuseCard"],
        canTokenizeCard: json["canTokenizeCard"],
        userId: json["userId"],
        bankId: json["bankId"],
        isActive: json["isActive"],
        isDefault: json["isDefault"],
        meta: Meta.fromJson(json["meta"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        bank: Bank.fromJson(json["bank"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uniqueId": uniqueId,
        "name": name,
        "processor": processor,
        "type": type,
        "panLast4": panLast4,
        "panFirst5": panFirst5,
        "maskedPan": maskedPan,
        "expiryDate": expiryDate.toIso8601String(),
        "canReuseCard": canReuseCard,
        "canTokenizeCard": canTokenizeCard,
        "userId": userId,
        "bankId": bankId,
        "isActive": isActive,
        "isDefault": isDefault,
        "meta": meta.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "bank": bank.toJson(),
      };
}

class Bank {
  Bank({
    required this.id,
    required this.name,
    required this.nipBankCode,
    required this.monnifyBankCode,
    required this.baseUssdCode,
    required this.ussdTransferTemplate,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  final String id;
  final String name;
  final dynamic nipBankCode;
  final String monnifyBankCode;
  final String baseUssdCode;
  final String ussdTransferTemplate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;

  factory Bank.fromRawJson(String str) => Bank.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        id: json["id"],
        name: json["name"],
        nipBankCode: json["nipBankCode"],
        monnifyBankCode: json["monnifyBankCode"],
        baseUssdCode: json["baseUssdCode"],
        ussdTransferTemplate: json["ussdTransferTemplate"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nipBankCode": nipBankCode,
        "monnifyBankCode": monnifyBankCode,
        "baseUssdCode": baseUssdCode,
        "ussdTransferTemplate": ussdTransferTemplate,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
      };
}

class Meta {
  Meta({
    required this.token,
  });

  final String token;

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
