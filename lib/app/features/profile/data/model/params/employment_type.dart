import 'package:equatable/equatable.dart';

class EmploymentType {
  static List<Map<String, dynamic>> employmentBody = [
    {"id": "fulltime_employed", "type": "Full-Time"},
    {"id": "self-employed", "type": "Self-Employed"},
    {"id": "parttime-employed", "type": "Part-Time"}
  ];

  List<Employment_> employmentTypes;

  EmploymentType({required this.employmentTypes});

  factory EmploymentType.fromMap(List<dynamic> countries) => EmploymentType(
        employmentTypes: List<Employment_>.from(
          countries.map(
            (e) => Employment_.fromJson(e),
          ),
        ),
      );

  static String? showCorrectEmploymentFormat(String? employmentStatus) {
    if (employmentStatus == 'fulltime_employed') {
      return "Full-Time";
    } else if (employmentStatus == 'self-employed') {
      return "Self-Employed";
    } else if (employmentStatus == 'parttime-employed') {
      return "Part-Time";
    }
    return employmentStatus;
  }

  @override
  String toString() => employmentTypes.toString();
}

class Employment_ extends Equatable {
  const Employment_({
    required this.id,
    required this.type,
  });

  final String id;
  final String type;

  factory Employment_.fromJson(Map<String, dynamic> json) => Employment_(
        id: json["id"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
      };

  @override
  List<Object?> get props => [id, type];
}
