import 'package:equatable/equatable.dart';

class RegisterParams{
  String? email;
  String? password;
  String? name;
  String? phoneNumber;
  String? dateOfBirth;

   RegisterParams({
    required this.email,
    required this.password,
    required this.name,
    required this.phoneNumber,
    required this.dateOfBirth,
  });

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "password": password,
      "name": name,
      "phoneNumber": phoneNumber,
      "dob": dateOfBirth,
    };
  }
}
