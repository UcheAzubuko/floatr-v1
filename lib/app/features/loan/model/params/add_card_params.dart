class VerifyMonnifyParams {
  final String transactionRef;

  VerifyMonnifyParams({required this.transactionRef});

  Map<String, dynamic> toMap() => {"transactionRef": transactionRef};
}
