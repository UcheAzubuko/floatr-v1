class ActivitiesResponse {
  final List<Activity> activities;

  ActivitiesResponse({required this.activities});

  factory ActivitiesResponse.fromJson(List<dynamic> data) =>
      ActivitiesResponse(activities: List<Activity>.from(data.map((e) => Activity.fromJson(e))));
}

class Activity {
  Activity({
    required this.uniqueId,
    required this.message,
    required this.createdAt,
  });

  final String uniqueId;
  final String message;
  final DateTime createdAt;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        uniqueId: json["uniqueId"],
        message: json["message"],
        createdAt: DateTime.parse(json["createdAt"]),
      );
}
