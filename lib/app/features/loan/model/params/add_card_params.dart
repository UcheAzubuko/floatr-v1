class AddCardParams {
  final String transactionRef;

  AddCardParams({required this.transactionRef});

  Map<String, dynamic> toMap() => {"transactionRef": transactionRef};
}
