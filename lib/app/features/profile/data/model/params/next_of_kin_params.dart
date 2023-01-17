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

    final String? firstName;
    final String? lastName;
    final String? relationship;
    final String? email;
    final String? phoneNumber;
    final String? countryId;
    final String? stateId;
    final String? city;
    final String? address;

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
