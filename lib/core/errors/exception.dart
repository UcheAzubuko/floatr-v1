class AuthException implements Exception {
  AuthException(this.message);
  final String? message;
}

class ServerException implements Exception {
  ServerException(this.message, this.code);
  final String? message;
  final int? code;
}
