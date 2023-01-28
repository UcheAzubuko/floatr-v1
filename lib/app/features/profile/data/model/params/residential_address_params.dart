class ResidentialAddressParams {
  ResidentialAddressParams({
    required this.countryId,
    required this.stateId,
    required this.city,
    required this.address,
  });

  String? countryId;
  String? stateId;
  String? city;
  String? address;

  Map<String, dynamic> toMap() => {
        "countryId": countryId,
        "stateId": stateId,
        "city": city,
        "address": address,
      };
}
