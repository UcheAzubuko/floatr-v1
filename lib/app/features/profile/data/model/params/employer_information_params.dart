class EmployerInformationParams {
    EmployerInformationParams({
        required this.employerName,
        required this.type,
        required this.minMonthlyIncome,
        required this.maxMonthlyIncome,
        required this.position,
        required this.employerAddress,
    });

    final String? employerName;
    final String? type;
    final String? minMonthlyIncome;
    final String? maxMonthlyIncome;
    final String? position;
    final String? employerAddress;

    Map<String, dynamic> toMap() => {
        "employerName": employerName,
        "type": type,
        "minMonthlyIncome": minMonthlyIncome,
        "maxMonthlyIncome": maxMonthlyIncome,
        "position": position,
        "employerAddress": employerAddress,
    };
}