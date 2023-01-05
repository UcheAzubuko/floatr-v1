class VerifyBVNParams {
  String? bvn;

  VerifyBVNParams({
    required this.bvn,
  });

  Map<String, String?> toMap() {
    return {
      "bvn": bvn,
    };
  }
}
