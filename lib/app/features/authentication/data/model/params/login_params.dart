class LoginParams  {
  String? email;
  String? password;

   LoginParams({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {"phone": email, "password": password};
  }

  // @override
  // List<Object?> get props => [email, password];
}
