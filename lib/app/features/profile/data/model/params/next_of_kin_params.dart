class NextOfKinParams {
  NextOfKinParams({
    required this.firstName,
    required this.lastName,
    required this.relationship,
    required this.email,
    required this.phoneNumber,
    required this.countryId,
    required this.stateId,
    required this.city,
    required this.address,
  });

  String? firstName;
  String? lastName;
  String? relationship;
  String? email;
  String? phoneNumber;
  String? countryId;
  String? stateId;
  String? city;
  String? address;

  Map<String, dynamic> toMap() => {
        "firstName": firstName,
        "lastName": lastName,
        "relationship": relationship,
        "email": email,
        "phoneNumber": phoneNumber,
        "countryId": countryId,
        "stateId": stateId,
        "city": city,
        "address": address,
      };
}
