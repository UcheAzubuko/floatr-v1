class ResidentialAddressParams {
    ResidentialAddressParams({
        required this.countryId,
        required this.stateId,
        required this.city,
        required this.address,
    });

    final String? countryId;
    final String? stateId;
    final String? city;
    final String? address;

    Map<String, dynamic> toMap() => {
        "countryId": countryId,
        "stateId": stateId,
        "city": city,
        "address": address,
    };
}