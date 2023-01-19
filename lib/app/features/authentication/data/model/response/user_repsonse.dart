// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

// import 'package:meta/meta.dart';
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

  final String? uniqueId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? bvn;
  final bool? isAnonymous;
  final DateTime? dateOfBirth;
  final String? city;
  final String? address;
  final bool? isOnline;
  final bool? isEmailVerified;
  final bool? isPhoneVerified;
  final bool? isBvnVerified;
  final bool? isActive;
  final bool? canLogin;
  final bool? canWithdraw;
  final bool? canRequestLoan;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final Gender? gender;
  final Gender? maritalStatus;
  final Country? country;
  final Country? state;
  final Country? stateOfOrigin;
  final NextOfKin? nextOfKin;
  final Employment? employment;
  final bool? hasSetPin;
  final bool? isPhotoVerified;
  final Photo? photo;
  final bool? isGovernmentIdVerified;
  final List<String?>? idTypes;

  factory UserResponse.fromRawJson(String str) =>
      UserResponse.fromJson(json.decode(str));

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
        gender: Gender.fromJson(json["gender"] ?? {}),
        maritalStatus: Gender.fromJson(json["maritalStatus"] ?? {}),
        country: Country.fromJson(json["country"] ?? {}),
        state: Country.fromJson(json["state"] ?? {}),
        stateOfOrigin: Country.fromJson(json["stateOfOrigin"] ?? {}),
        nextOfKin: NextOfKin.fromMap(json["nextOfKin"] ??
            NextOfKin(
                    uniqueId: null,
                    firstName: null,
                    lastName: null,
                    email: null,
                    phoneNumber: null,
                    relationship: null,
                    city: null,
                    address: null,
                    country: null,
                    state: null,
                    gender: null)
                .toMap()),
        employment: Employment.fromJson(json["employment"] ?? {}),
        hasSetPin: json["hasSetPin"],
        isPhotoVerified: json["isPhotoVerified"],
        photo: Photo.fromJson(json["photo"]),
        isGovernmentIdVerified: json["isGovernmentIdVerified"],
        idTypes: json["idTypes"] == null
            ? []
            : List<String?>.from(json["idTypes"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "uniqueId": uniqueId,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "bvn": bvn,
        "isAnonymous": isAnonymous,
        "dateOfBirth": dateOfBirth?.toIso8601String(),
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
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "gender": gender!.toJson(),
        "maritalStatus": maritalStatus!.toJson(),
        "country": country!.toJson(),
        "state": state!.toJson(),
        "stateOfOrigin": stateOfOrigin!.toJson(),
        "nextOfKin": nextOfKin!.toMap(),
        "employment": employment!.toJson(),
        "hasSetPin": hasSetPin,
        "isPhotoVerified": isPhotoVerified,
        "photo": photo!.toJson(),
        "isGovernmentIdVerified": isGovernmentIdVerified,
        "idTypes":
            idTypes == null ? [] : List<dynamic>.from(idTypes!.map((x) => x)),
      };
}

class Country {
  Country({
    required this.id,
    required this.name,
    required this.code,
    required this.iso2,
    required this.iso3,
    required this.flag,
  });

  final String? id;
  final String? name;
  final String? code;
  final String? iso2;
  final String? iso3;
  final dynamic flag;

  factory Country.fromRawJson(String str) => Country.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        iso2: json["iso2"],
        iso3: json["iso3"],
        flag: json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "iso2": iso2,
        "iso3": iso3,
        "flag": flag,
      };
}

class Employment {
  Employment({
    required this.uniqueId,
    required this.employerName,
    required this.type,
    required this.minMonthlyIncome,
    required this.maxMonthlyIncome,
    required this.position,
    required this.employerAddress,
  });

  final String? uniqueId;
  final String? employerName;
  final String? type;
  final String? minMonthlyIncome;
  final String? maxMonthlyIncome;
  final String? position;
  final String? employerAddress;

  factory Employment.fromRawJson(String str) =>
      Employment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Employment.fromJson(Map<String, dynamic> json) => Employment(
        uniqueId: json["uniqueId"],
        employerName: json["employerName"],
        type: json["type"],
        minMonthlyIncome: json["minMonthlyIncome"],
        maxMonthlyIncome: json["maxMonthlyIncome"],
        position: json["position"],
        employerAddress: json["employerAddress"],
      );

  Map<String, dynamic> toJson() => {
        "uniqueId": uniqueId,
        "employerName": employerName,
        "type": type,
        "minMonthlyIncome": minMonthlyIncome,
        "maxMonthlyIncome": maxMonthlyIncome,
        "position": position,
        "employerAddress": employerAddress,
      };
}

class Gender {
  Gender({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  factory Gender.fromRawJson(String str) => Gender.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Gender.fromJson(Map<String, dynamic> json) => Gender(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class NextOfKin {
  NextOfKin({
    required this.uniqueId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.relationship,
    required this.city,
    required this.address,
    required this.country,
    required this.state,
    required this.gender,
  });

  final String? uniqueId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? relationship;
  final String? city;
  final String? address;
  final Country? country;
  final Country? state;
  final dynamic gender;

  factory NextOfKin.fromJson(String str) => NextOfKin.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NextOfKin.fromMap(Map<String, dynamic> json) => NextOfKin(
        uniqueId: json["uniqueId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        relationship: json["relationship"],
        city: json["city"],
        address: json["address"],
        country: Country.fromJson(json["country"] ?? {}),
        state: Country.fromJson(json["state"] ?? {}),
        gender: json["gender"],
      );

  Map<String, dynamic> toMap() => {
        "uniqueId": uniqueId,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "relationship": relationship,
        "city": city,
        "address": address,
        "country": country,
        "state": state,
        "gender": gender,
      };
}

class Photo {
  Photo({
    required this.uniqueId,
    required this.name,
    required this.ext,
    required this.size,
    required this.purpose,
    required this.meta,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.url,
  });

  final String? uniqueId;
  final String? name;
  final String? ext;
  final String? size;
  final String? purpose;
  final dynamic meta;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final String? url;

  factory Photo.fromRawJson(String str) => Photo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        uniqueId: json["uniqueId"],
        name: json["name"],
        ext: json["ext"],
        size: json["size"],
        purpose: json["purpose"],
        meta: json["meta"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "uniqueId": uniqueId,
        "name": name,
        "ext": ext,
        "size": size,
        "purpose": purpose,
        "meta": meta,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "url": url,
      };
}
