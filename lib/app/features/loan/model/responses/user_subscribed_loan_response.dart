// To parse this JSON data, do
//
//     final userSubscribedLoanResponse = userSubscribedLoanResponseFromJson(jsonString);

import 'dart:convert';

class UserSubscribedLoanResponse {
  UserSubscribedLoanResponse({
    required this.uniqueId,
    required this.loanName,
    required this.amount,
    required this.totalPayBackAmount,
    required this.totalPaidBackAmount,
    required this.totalCharges,
    required this.tenureInDays,
    required this.minAmount,
    required this.maxAmount,
    required this.interestChargeType,
    required this.interestCharge,
    required this.platformChargeType,
    required this.platformCharge,
    required this.defaultDailyCharge,
    required this.minTenureInDays,
    required this.maxTenureInDays,
    required this.wasAutoRespondedTo,
    required this.status,
    required this.dueDate,
    required this.approvedAt,
    required this.deniedAt,
    required this.releasedAt,
    required this.settledAt,
    required this.meta,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.card,
    required this.bank,
    this.approvedBy,
    required this.loan,
    required this.paymentSchedules,
    required this.user,
    required this.additions,
  });

  final String uniqueId;
  final String loanName;
  final String amount;
  final String totalPayBackAmount;
  final String totalPaidBackAmount;
  final String totalCharges;
  final int tenureInDays;
  final String minAmount;
  final String maxAmount;
  final String interestChargeType;
  final String interestCharge;
  final String platformChargeType;
  final String platformCharge;
  final String defaultDailyCharge;
  final int minTenureInDays;
  final int maxTenureInDays;
  final bool? wasAutoRespondedTo;
  final LoanAppLicationStatus status;
  final DateTime dueDate;
  final DateTime approvedAt;
  final dynamic deniedAt;
  final dynamic releasedAt;
  final dynamic settledAt;
  final Meta meta;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final Card card;
  final UserSubscribedLoanResponseBank bank;
  final ApprovedBy? approvedBy;
  final UserSubscribedLoanResponseLoan loan;
  final List<PaymentSchedule> paymentSchedules;
  final User user;
  final List<dynamic> additions;

  factory UserSubscribedLoanResponse.fromRawJson(String str) =>
      UserSubscribedLoanResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserSubscribedLoanResponse.fromJson(Map<String, dynamic> json) =>
      UserSubscribedLoanResponse(
        uniqueId: json["uniqueId"],
        loanName: json["loanName"],
        amount: json["amount"],
        totalPayBackAmount: json["totalPayBackAmount"],
        totalPaidBackAmount: json["totalPaidBackAmount"],
        totalCharges: json["totalCharges"],
        tenureInDays: json["tenureInDays"],
        minAmount: json["minAmount"],
        maxAmount: json["maxAmount"],
        interestChargeType: json["interestChargeType"],
        interestCharge: json["interestCharge"],
        platformChargeType: json["platformChargeType"],
        platformCharge: json["platformCharge"],
        defaultDailyCharge: json["defaultDailyCharge"],
        minTenureInDays: json["minTenureInDays"],
        maxTenureInDays: json["maxTenureInDays"],
        wasAutoRespondedTo: json["wasAutoRespondedTo"],
        status: getLoanApplicationStatus(json["status"]),
        dueDate: DateTime.parse(json["dueDate"]),
        approvedAt: DateTime.parse(
            json["approvedAt"] ?? DateTime.now().toIso8601String()),
        deniedAt: json["deniedAt"],
        releasedAt: json["releasedAt"],
        settledAt: json["settledAt"],
        meta: Meta.fromJson(json["meta"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        card: Card.fromJson(json["card"]),
        bank: UserSubscribedLoanResponseBank.fromJson(json["bank"]),
        approvedBy: ApprovedBy.fromJson(json["approvedBy"] ?? {}),
        loan: UserSubscribedLoanResponseLoan.fromJson(json["loan"]),
        paymentSchedules: List<PaymentSchedule>.from(
            json["paymentSchedules"].map((x) => PaymentSchedule.fromJson(x))),
        user: User.fromJson(json["user"]),
        additions: List<dynamic>.from(json["additions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "uniqueId": uniqueId,
        "loanName": loanName,
        "amount": amount,
        "totalPayBackAmount": totalPayBackAmount,
        "totalPaidBackAmount": totalPaidBackAmount,
        "totalCharges": totalCharges,
        "tenureInDays": tenureInDays,
        "minAmount": minAmount,
        "maxAmount": maxAmount,
        "interestChargeType": interestChargeType,
        "interestCharge": interestCharge,
        "platformChargeType": platformChargeType,
        "platformCharge": platformCharge,
        "defaultDailyCharge": defaultDailyCharge,
        "minTenureInDays": minTenureInDays,
        "maxTenureInDays": maxTenureInDays,
        "wasAutoRespondedTo": wasAutoRespondedTo,
        "status": status,
        "dueDate": dueDate.toIso8601String(),
        "approvedAt": approvedAt.toIso8601String(),
        "deniedAt": deniedAt,
        "releasedAt": releasedAt,
        "settledAt": settledAt,
        "meta": meta.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "card": card.toJson(),
        "bank": bank.toJson(),
        "approvedBy": approvedBy!.toJson(),
        "loan": loan.toJson(),
        "paymentSchedules": List<dynamic>.from(paymentSchedules.map((x) => x)),
        "user": user.toJson(),
        "additions": List<dynamic>.from(additions.map((x) => x)),
      };
}

class ApprovedBy {
  ApprovedBy({
    this.uniqueId,
    this.name,
    this.email,
    this.username,
    this.phoneNumber,
    this.isSuperAdmin,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  final String? uniqueId;
  final String? name;
  final String? email;
  final String? username;
  final String? phoneNumber;
  final bool? isSuperAdmin;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  factory ApprovedBy.fromRawJson(String str) =>
      ApprovedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApprovedBy.fromJson(Map<String, dynamic> json) => ApprovedBy(
        uniqueId: json["uniqueId"],
        name: json["name"],
        email: json["email"],
        username: json["username"],
        phoneNumber: json["phoneNumber"],
        isSuperAdmin: json["isSuperAdmin"],
        isActive: json["isActive"],
        createdAt: DateTime.parse(
            json["createdAt"] ?? DateTime.now().toIso8601String()),
        updatedAt: DateTime.parse(
            json["updatedAt"] ?? DateTime.now().toIso8601String()),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "uniqueId": uniqueId,
        "name": name,
        "email": email,
        "username": username,
        "phoneNumber": phoneNumber,
        "isSuperAdmin": isSuperAdmin,
        "isActive": isActive,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "deletedAt": deletedAt,
      };
}

class UserSubscribedLoanResponseBank {
  UserSubscribedLoanResponseBank({
    required this.uniqueId,
    required this.accountNo,
    required this.accountName,
    required this.isActive,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.bank,
  });

  final String uniqueId;
  final String accountNo;
  final String accountName;
  final bool isActive;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final BankBank bank;

  factory UserSubscribedLoanResponseBank.fromRawJson(String str) =>
      UserSubscribedLoanResponseBank.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserSubscribedLoanResponseBank.fromJson(Map<String, dynamic> json) =>
      UserSubscribedLoanResponseBank(
        uniqueId: json["uniqueId"],
        accountNo: json["accountNo"],
        accountName: json["accountName"],
        isActive: json["isActive"],
        isDefault: json["isDefault"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        bank: BankBank.fromJson(json["bank"]),
      );

  Map<String, dynamic> toJson() => {
        "uniqueId": uniqueId,
        "accountNo": accountNo,
        "accountName": accountName,
        "isActive": isActive,
        "isDefault": isDefault,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "bank": bank.toJson(),
      };
}

class BankBank {
  BankBank({
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

  factory BankBank.fromRawJson(String str) =>
      BankBank.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BankBank.fromJson(Map<String, dynamic> json) => BankBank(
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

class Card {
  Card({
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
    required this.isActive,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

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
  final bool isActive;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;

  factory Card.fromRawJson(String str) => Card.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Card.fromJson(Map<String, dynamic> json) => Card(
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
        isActive: json["isActive"],
        isDefault: json["isDefault"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
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
        "isActive": isActive,
        "isDefault": isDefault,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
      };
}

class UserSubscribedLoanResponseLoan {
  UserSubscribedLoanResponseLoan({
    required this.uniqueId,
    required this.name,
    required this.minAmount,
    required this.maxAmount,
    required this.interestChargeType,
    required this.interestCharge,
    required this.platformChargeType,
    required this.platformCharge,
    required this.defaultDailyCharge,
    required this.minTenureInDays,
    required this.maxTenureInDays,
    required this.isActive,
    required this.orderingMarker,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  final String uniqueId;
  final String name;
  final String minAmount;
  final String maxAmount;
  final String interestChargeType;
  final String interestCharge;
  final String platformChargeType;
  final String platformCharge;
  final String defaultDailyCharge;
  final int minTenureInDays;
  final int maxTenureInDays;
  final bool isActive;
  final int orderingMarker;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;

  factory UserSubscribedLoanResponseLoan.fromRawJson(String str) =>
      UserSubscribedLoanResponseLoan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserSubscribedLoanResponseLoan.fromJson(Map<String, dynamic> json) =>
      UserSubscribedLoanResponseLoan(
        uniqueId: json["uniqueId"],
        name: json["name"],
        minAmount: json["minAmount"],
        maxAmount: json["maxAmount"],
        interestChargeType: json["interestChargeType"],
        interestCharge: json["interestCharge"],
        platformChargeType: json["platformChargeType"],
        platformCharge: json["platformCharge"],
        defaultDailyCharge: json["defaultDailyCharge"],
        minTenureInDays: json["minTenureInDays"],
        maxTenureInDays: json["maxTenureInDays"],
        isActive: json["isActive"],
        orderingMarker: json["orderingMarker"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "uniqueId": uniqueId,
        "name": name,
        "minAmount": minAmount,
        "maxAmount": maxAmount,
        "interestChargeType": interestChargeType,
        "interestCharge": interestCharge,
        "platformChargeType": platformChargeType,
        "platformCharge": platformCharge,
        "defaultDailyCharge": defaultDailyCharge,
        "minTenureInDays": minTenureInDays,
        "maxTenureInDays": maxTenureInDays,
        "isActive": isActive,
        "orderingMarker": orderingMarker,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
      };
}

class Meta {
  Meta({
    required this.loan,
  });

  final MetaLoan loan;

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        loan: MetaLoan.fromJson(json["loan"]),
      );

  Map<String, dynamic> toJson() => {
        "loan": loan.toJson(),
      };
}

class MetaLoan {
  MetaLoan({
    required this.id,
    required this.name,
    required this.isActive,
    required this.uniqueId,
    required this.createdAt,
    required this.deletedAt,
    required this.maxAmount,
    required this.minAmount,
    required this.updatedAt,
    required this.adminUserId,
    required this.interestCharge,
    required this.orderingMarker,
    required this.platformCharge,
    required this.maxTenureInDays,
    required this.minTenureInDays,
    required this.defaultDailyCharge,
    required this.interestChargeType,
    required this.platformChargeType,
  });

  final int id;
  final String name;
  final bool isActive;
  final String uniqueId;
  final DateTime createdAt;
  final dynamic deletedAt;
  final int maxAmount;
  final int minAmount;
  final DateTime updatedAt;
  final int adminUserId;
  final int interestCharge;
  final int orderingMarker;
  final int platformCharge;
  final int maxTenureInDays;
  final int minTenureInDays;
  final int defaultDailyCharge;
  final String interestChargeType;
  final String platformChargeType;

  factory MetaLoan.fromRawJson(String str) =>
      MetaLoan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MetaLoan.fromJson(Map<String, dynamic> json) => MetaLoan(
        id: json["id"],
        name: json["name"],
        isActive: json["isActive"],
        uniqueId: json["uniqueId"],
        createdAt: DateTime.parse(json["createdAt"]),
        deletedAt: json["deletedAt"],
        maxAmount: json["maxAmount"],
        minAmount: json["minAmount"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        adminUserId: json["adminUserId"],
        interestCharge: json["interestCharge"],
        orderingMarker: json["orderingMarker"],
        platformCharge: json["platformCharge"],
        maxTenureInDays: json["maxTenureInDays"],
        minTenureInDays: json["minTenureInDays"],
        defaultDailyCharge: json["defaultDailyCharge"],
        interestChargeType: json["interestChargeType"],
        platformChargeType: json["platformChargeType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "isActive": isActive,
        "uniqueId": uniqueId,
        "createdAt": createdAt.toIso8601String(),
        "deletedAt": deletedAt,
        "maxAmount": maxAmount,
        "minAmount": minAmount,
        "updatedAt": updatedAt.toIso8601String(),
        "adminUserId": adminUserId,
        "interestCharge": interestCharge,
        "orderingMarker": orderingMarker,
        "platformCharge": platformCharge,
        "maxTenureInDays": maxTenureInDays,
        "minTenureInDays": minTenureInDays,
        "defaultDailyCharge": defaultDailyCharge,
        "interestChargeType": interestChargeType,
        "platformChargeType": platformChargeType,
      };
}

class PaymentSchedule {
  PaymentSchedule({
    this.id,
    this.uniqueId,
    this.amount,
    this.status,
    this.retryCount,
    this.userCardId,
    this.userLoanApplicationId,
    this.userId,
    this.dueDate,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  final String? id;
  final String? uniqueId;
  final String? amount;
  final String? status;
  final int? retryCount;
  final String? userCardId;
  final String? userLoanApplicationId;
  final String? userId;
  final DateTime? dueDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  factory PaymentSchedule.fromJson(Map<String, dynamic> json) =>
      PaymentSchedule(
        id: json["id"],
        uniqueId: json["uniqueId"],
        amount: json["amount"],
        status: json["status"],
        retryCount: json["retryCount"],
        userCardId: json["userCardId"],
        userLoanApplicationId: json["userLoanApplicationId"],
        userId: json["userId"],
        dueDate:
            DateTime.parse(json["dueDate"] ?? DateTime.now().toIso8601String()),
        createdAt: DateTime.parse(
            json["createdAt"] ?? DateTime.now().toIso8601String()),
        updatedAt: DateTime.parse(
            json["updatedAt"] ?? DateTime.now().toIso8601String()),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uniqueId": uniqueId,
        "amount": amount,
        "status": status,
        "retryCount": retryCount,
        "userCardId": userCardId,
        "userLoanApplicationId": userLoanApplicationId,
        "userId": userId,
        "dueDate": dueDate!.toIso8601String(),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "deletedAt": deletedAt,
      };
}

class User {
  User({
    required this.uniqueId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.bvn,
    required this.isAnonymous,
    required this.dateOfBirth,
    required this.city,
    required this.address,
    required this.isOnline,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    required this.isBvnVerified,
    required this.isActive,
    required this.canLogin,
    required this.canWithdraw,
    required this.canRequestLoan,
    required this.level,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.isPhotoVerified,
    required this.photo,
    required this.isGovernmentIdVerified,
    required this.idTypes,
  });

  final String uniqueId;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String bvn;
  final bool isAnonymous;
  final DateTime dateOfBirth;
  final String city;
  final String address;
  final bool isOnline;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final bool isBvnVerified;
  final bool isActive;
  final bool canLogin;
  final bool canWithdraw;
  final bool canRequestLoan;
  final int level;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final bool isPhotoVerified;
  final Photo photo;
  final bool isGovernmentIdVerified;
  final List<String> idTypes;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        uniqueId: json["uniqueId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        bvn: json["bvn"],
        isAnonymous: json["isAnonymous"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        city: json["city"],
        address: json["address"],
        isOnline: json["isOnline"],
        isEmailVerified: json["isEmailVerified"],
        isPhoneVerified: json["isPhoneVerified"],
        isBvnVerified: json["isBvnVerified"],
        isActive: json["isActive"],
        canLogin: json["canLogin"],
        canWithdraw: json["canWithdraw"],
        canRequestLoan: json["canRequestLoan"],
        level: json["level"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        isPhotoVerified: json["isPhotoVerified"],
        photo: Photo.fromJson(json["photo"]),
        isGovernmentIdVerified: json["isGovernmentIdVerified"],
        idTypes: List<String>.from(json["idTypes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "uniqueId": uniqueId,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "bvn": bvn,
        "isAnonymous": isAnonymous,
        "dateOfBirth": dateOfBirth.toIso8601String(),
        "city": city,
        "address": address,
        "isOnline": isOnline,
        "isEmailVerified": isEmailVerified,
        "isPhoneVerified": isPhoneVerified,
        "isBvnVerified": isBvnVerified,
        "isActive": isActive,
        "canLogin": canLogin,
        "canWithdraw": canWithdraw,
        "canRequestLoan": canRequestLoan,
        "level": level,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "isPhotoVerified": isPhotoVerified,
        "photo": photo.toJson(),
        "isGovernmentIdVerified": isGovernmentIdVerified,
        "idTypes": List<dynamic>.from(idTypes.map((x) => x)),
      };
}

class Photo {
  Photo({
    required this.uniqueId,
    required this.name,
    required this.ext,
    required this.size,
    required this.purpose,
    required this.meta,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.url,
  });

  final String uniqueId;
  final String name;
  final String ext;
  final String size;
  final String purpose;
  final dynamic meta;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final String url;

  factory Photo.fromRawJson(String str) => Photo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        uniqueId: json["uniqueId"],
        name: json["name"],
        ext: json["ext"],
        size: json["size"],
        purpose: json["purpose"],
        meta: json["meta"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "uniqueId": uniqueId,
        "name": name,
        "ext": ext,
        "size": size,
        "purpose": purpose,
        "meta": meta,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "url": url,
      };
}

LoanAppLicationStatus getLoanApplicationStatus(String status) {
  switch (status) {
    case 'approved':
      return LoanAppLicationStatus.approved;
    case 'denied':
      return LoanAppLicationStatus.denied;
    case 'pending-approval':
      return LoanAppLicationStatus.pendingApproval;

    case 'pending-disbursment':
      return LoanAppLicationStatus.pendingDisbursment;
    case 'fully-settled':
      return LoanAppLicationStatus.fullySettled;
    case 'settling':
      return LoanAppLicationStatus.settling;

    default:
      return LoanAppLicationStatus.denied;
  }
}

enum LoanAppLicationStatus {
  approved,
  denied,
  pendingApproval,
  pendingDisbursment,
  fullySettled,
  settling;
}
