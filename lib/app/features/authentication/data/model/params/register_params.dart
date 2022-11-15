import 'package:equatable/equatable.dart';

class RegisterParams extends Equatable {
  final String email;
  final String password;
  final String name;
  final String phoneNumber;
  final String dateOfBirth;

  const RegisterParams({
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

  @override
  List<Object?> get props => [email, password, name, phoneNumber, dateOfBirth];
}
