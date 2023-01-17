class UserProfileParams {
    UserProfileParams({
        required this.email,
        required this.genderId,
        required this.maritalStatusId,
        required this.stateOfOriginId,
    });

    final String? email;
    final String? genderId;
    final String? maritalStatusId;
    final String? stateOfOriginId;

    Map<String, dynamic> toMap() => {
        "email": email,
        "genderId": genderId,
        "maritalStatusId": maritalStatusId,
        "stateOfOriginId": stateOfOriginId,
    };
}