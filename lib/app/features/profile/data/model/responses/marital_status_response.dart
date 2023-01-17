import 'dart:convert';

class MaritalStatusResponse {
  List<MaritalStatus> maritalStatuses;

  MaritalStatusResponse({required this.maritalStatuses});

  factory MaritalStatusResponse.fromMap(List<dynamic> maritalStatuses) =>
      MaritalStatusResponse(
        maritalStatuses: List<MaritalStatus>.from(
          maritalStatuses.map(
            (e) => MaritalStatus.fromJson(e),
          ),
        ),
      );

  @override
  String toString() => maritalStatuses.toString();
}

class MaritalStatus {
  MaritalStatus({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  factory MaritalStatus.fromRawJson(String str) =>
      MaritalStatus.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MaritalStatus.fromJson(Map<String, dynamic> json) => MaritalStatus(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  @override
  String toString() => toJson().toString();
}
