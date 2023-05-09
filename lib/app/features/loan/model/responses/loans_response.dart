import 'dart:convert';

class LoansResponse {
  LoansResponse({required this.loans});

  final List<Loan> loans;

  factory LoansResponse.fromJson(List<dynamic> data) =>
      LoansResponse(loans: List<Loan>.from(data.map((e) => Loan.fromJson(e))));

  // LoansResponse.toList(List<dynamic> data)
  //     : loansResponse = List<Loan>.from(data.map((e) => Loan.fromJson(e)));
}

class Loan {
  Loan({
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
    required this.adminUserId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.orderingMarker,
     this.displayedAmountOnCard,
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
  final String adminUserId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final int orderingMarker;
  final String? displayedAmountOnCard;

  factory Loan.fromRawJson(String str) => Loan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Loan.fromJson(Map<String, dynamic> json) => Loan(
        uniqueId: json["uniqueId"],
        name: json["name"],
        minAmount: json["minAmount"],
        maxAmount: json["maxAmount"].toString(),
        interestChargeType: json["interestChargeType"],
        interestCharge: json["interestCharge"],
        platformChargeType: json["platformChargeType"],
        platformCharge: json["platformCharge"],
        defaultDailyCharge: json["defaultDailyCharge"],
        minTenureInDays: json["minTenureInDays"],
        maxTenureInDays: json["maxTenureInDays"],
        isActive: json["isActive"],
        adminUserId: json["adminUserId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        orderingMarker: json["orderingMarker"],
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
        "adminUserId": adminUserId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "orderingMarker": orderingMarker,
      };
}
