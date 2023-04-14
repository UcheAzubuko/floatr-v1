class LoanBalanceResponse {
  LoanBalanceResponse({
    required this.uniqueId,
    required this.amount,
    required this.pendingSchedules,
  });

  final String uniqueId;
  final int amount;
  final List<PendingSchedule> pendingSchedules;

  factory LoanBalanceResponse.fromJson(Map<String, dynamic> json) =>
      LoanBalanceResponse(
        uniqueId: json["uniqueId"],
        amount: json["amount"],
        pendingSchedules: List<PendingSchedule>.from(
            json["pendingSchedules"].map((x) => PendingSchedule.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uniqueId": uniqueId,
        "amount": amount,
        "pendingSchedules":
            List<dynamic>.from(pendingSchedules.map((x) => x.toJson())),
      };
}

class PendingSchedule {
  PendingSchedule({
    required this.uniqueId,
    required this.amount,
  });

  final String uniqueId;
  final String amount;

  factory PendingSchedule.fromJson(Map<String, dynamic> json) =>
      PendingSchedule(
        uniqueId: json["uniqueId"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "uniqueId": uniqueId,
        "amount": amount,
      };
}
