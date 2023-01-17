import 'dart:convert';

import 'package:equatable/equatable.dart';

class CountryResponse {
  List<Country> countries;

  CountryResponse({required this.countries});

  factory CountryResponse.fromMap(List<dynamic> countries) => CountryResponse(
        countries: List<Country>.from(
          countries.map(
            (e) => Country.fromJson(e),
          ),
        ),
      );

  @override
  String toString() => countries.toString();
}

class Country extends Equatable{
  const Country({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  factory Country.fromRawJson(String str) => Country.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Country.fromJson(Map<String, dynamic> json) => Country(
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
