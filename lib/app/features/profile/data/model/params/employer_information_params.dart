class EmployerInformationParams {
  EmployerInformationParams({
    required this.employerName,
    required this.type,
    required this.minMonthlyIncome,
    required this.maxMonthlyIncome,
    required this.position,
    required this.employerAddress,
  });

  String? employerName;
  String? type;
  String? minMonthlyIncome;
  String? maxMonthlyIncome;
  String? position;
  String? employerAddress;

  Map<String, dynamic> toMap() => {
        "employerName": employerName,
        "type": type,
        "minMonthlyIncome": minMonthlyIncome,
        "maxMonthlyIncome": maxMonthlyIncome,
        "position": position,
        "employerAddress": employerAddress,
      };
}
