import 'dart:convert';

class UserResponse {
    UserResponse({
        required this.uniqueId,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.phoneNumber,
        required this.bvn,
        required this.isAnonymous,
        required this.dateOfBirth,
        required this.city,
        required this.address,
        required this.isOnline,
        required this.isEmailVerified,
        required this.isPhoneVerified,
        required this.isBvnVerified,
        required this.isActive,
        required this.canLogin,
        required this.canWithdraw,
        required this.canRequestLoan,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.gender,
        required this.maritalStatus,
        required this.country,
        required this.state,
        required this.stateOfOrigin,
        required this.nextOfKin,
        required this.employment,
        required this.hasSetPin,
        required this.isPhotoVerified,
        required this.photo,
        required this.isGovernmentIdVerified,
        required this.idTypes,
    });

    final String uniqueId;
    final String firstName;
    final String lastName;
    final String email;
    final String phoneNumber;
    final dynamic bvn;
    final bool isAnonymous;
    final DateTime dateOfBirth;
    final dynamic city;
    final dynamic address;
    final bool isOnline;
    final bool isEmailVerified;
    final bool isPhoneVerified;
    final bool isBvnVerified;
    final bool isActive;
    final bool canLogin;
    final bool canWithdraw;
    final bool canRequestLoan;
    final DateTime createdAt;
    final DateTime updatedAt;
    final dynamic deletedAt;
    final dynamic gender;
    final dynamic maritalStatus;
    final dynamic country;
    final dynamic state;
    final dynamic stateOfOrigin;
    final dynamic nextOfKin;
    final dynamic employment;
    final bool hasSetPin;
    final bool isPhotoVerified;
    final dynamic photo;
    final bool isGovernmentIdVerified;
    final List<dynamic> idTypes;

    factory UserResponse.fromRawJson(String str) => UserResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        uniqueId: json["uniqueId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        bvn: json["bvn"],
        isAnonymous: json["isAnonymous"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        city: json["city"],
        address: json["address"],
        isOnline: json["isOnline"],
        isEmailVerified: json["isEmailVerified"],
        isPhoneVerified: json["isPhoneVerified"],
        isBvnVerified: json["isBvnVerified"],
        isActive: json["isActive"],
        canLogin: json["canLogin"],
        canWithdraw: json["canWithdraw"],
        canRequestLoan: json["canRequestLoan"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        gender: json["gender"],
        maritalStatus: json["maritalStatus"],
        country: json["country"],
        state: json["state"],
        stateOfOrigin: json["stateOfOrigin"],
        nextOfKin: json["nextOfKin"],
        employment: json["employment"],
        hasSetPin: json["hasSetPin"],
        isPhotoVerified: json["isPhotoVerified"],
        photo: json["photo"],
        isGovernmentIdVerified: json["isGovernmentIdVerified"],
        idTypes: List<dynamic>.from(json["idTypes"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "uniqueId": uniqueId,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "bvn": bvn,
        "isAnonymous": isAnonymous,
        "dateOfBirth": dateOfBirth.toIso8601String(),
        "city": city,
        "address": address,
        "isOnline": isOnline,
        "isEmailVerified": isEmailVerified,
        "isPhoneVerified": isPhoneVerified,
        "isBvnVerified": isBvnVerified,
        "isActive": isActive,
        "canLogin": canLogin,
        "canWithdraw": canWithdraw,
        "canRequestLoan": canRequestLoan,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "gender": gender,
        "maritalStatus": maritalStatus,
        "country": country,
        "state": state,
        "stateOfOrigin": stateOfOrigin,
        "nextOfKin": nextOfKin,
        "employment": employment,
        "hasSetPin": hasSetPin,
        "isPhotoVerified": isPhotoVerified,
        "photo": photo,
        "isGovernmentIdVerified": isGovernmentIdVerified,
        "idTypes": List<dynamic>.from(idTypes.map((x) => x)),
    };
}