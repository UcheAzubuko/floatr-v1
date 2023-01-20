import 'dart:convert';

import 'package:equatable/equatable.dart';

class GenderResponse {
  List<Gender> genders;

  GenderResponse({required this.genders});

  factory GenderResponse.fromMap(List<dynamic> genders) => GenderResponse(
        genders: List<Gender>.from(
          genders.map(
            (e) => Gender.fromJson(e),
          ),
        ),
      );

  @override
  String toString() => genders.toString();
}

class Gender extends Equatable{
  const Gender({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  factory Gender.fromRawJson(String str) => Gender.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Gender.fromJson(Map<String, dynamic> json) => Gender(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  @override
  String toString() => toJson().toString();
  
  @override
  List<Object?> get props => [id, name];
}
