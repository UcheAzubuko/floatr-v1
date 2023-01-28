class UserProfileParams {
  UserProfileParams({
    required this.email,
    required this.genderId,
    required this.maritalStatusId,
    required this.stateOfOriginId,
  });

  String? email;
  String? genderId;
  String? maritalStatusId;
  String? stateOfOriginId;

  Map<String, dynamic> toMap() => {
        "email": email,
        "genderId": genderId,
        "maritalStatusId": maritalStatusId,
        "stateOfOriginId": stateOfOriginId,
      };
}
