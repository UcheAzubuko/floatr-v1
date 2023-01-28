import 'dart:convert';

import 'package:equatable/equatable.dart';

class StateResponse {
  List<State> stateResponses;

  StateResponse({required this.stateResponses});

  factory StateResponse.fromMap(List<dynamic> stateResponses) => StateResponse(
        stateResponses: List<State>.from(
          stateResponses.map(
            (e) => State.fromJson(e),
          ),
        ),
      );

  @override
  String toString() => stateResponses.toString();
}

class State extends Equatable{
  const State({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  factory State.fromRawJson(String str) => State.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory State.fromJson(Map<String, dynamic> json) => State(
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
