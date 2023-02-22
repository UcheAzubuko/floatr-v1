import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  // const Failure();

  const Failure({this.code, this.message});
  final String? code;
  final String? message;

  @override
  List<Object> get props => [];
}

class AuthFailure extends Failure {
  const AuthFailure({String? code, String? message})
      : super(code: code, message: message);
}

class ServerFailure extends Failure {
  const ServerFailure({String? code, String? message})
      : super(code: code, message: message);
}

class LocalAuthFailure extends Failure {
  const LocalAuthFailure({String? code, String? message})
      : super(code: code, message: message);
}