part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class RequestOtp extends AuthEvent {
  final String phone;
  final String signature;
  final bool forcefully;

  const RequestOtp(this.phone, this.signature, {this.forcefully = false});

  @override
  List<Object> get props => [phone, signature, forcefully];
}

class VerifyOtp extends AuthEvent {
  final String phone;
  final String otp;

  const VerifyOtp(this.phone, this.otp);

  @override
  List<Object> get props => [phone, otp];
}

class DoExist extends AuthEvent {
  final String phone;
  final RegistrationBody body;

  const DoExist(this.phone, this.body);

  @override
  List<Object> get props => [phone, body];
}

class Register extends AuthEvent {
  final RegistrationBody body;

  const Register(this.body);

  @override
  List<Object> get props => [body];
}

class Login extends AuthEvent {
  final String phone;
  final bool isAuthor;

  const Login(this.phone, this.isAuthor);

  @override
  List<Object> get props => [phone, isAuthor];
}

class ToggleSignUp extends AuthEvent {
  final bool open;

  const ToggleSignUp(this.open);

  @override
  List<Object> get props => [open];
}

class VerifyReferenceCode extends AuthEvent {
  final String code;

  const VerifyReferenceCode(this.code);

  @override
  List<Object> get props => [code];
}

class AuthenticateWithTruecaller extends AuthEvent {
  final String payload;

  const AuthenticateWithTruecaller(this.payload);

  @override
  List<Object> get props => [payload];
}
