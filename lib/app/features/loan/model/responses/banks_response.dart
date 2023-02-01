class BanksResponse {
  List<Bank> banks;

  BanksResponse({required this.banks});

  factory BanksResponse.fromJson(List<dynamic> data) =>
      BanksResponse(banks: List<Bank>.from(data.map((e) => Bank.fromJson(e))));
}

class Bank {
  final String id;
  final String name;

  Bank({required this.id, required this.name});

  factory Bank.fromJson(Map<String, dynamic> json) =>
      Bank(id: json["id"], name: json["name"]);
}
