part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  List<Object?> get props => [];
}

class Requesting extends AuthState {
  const Requesting({this.saving = false, this.sendingOtp = false, this.verifyingOtp = false, this.checking = false, this.isSignUpOpened = false});

  final bool? sendingOtp;
  final bool? checking;
  final bool? verifyingOtp;
  final bool? saving;
  final bool? isSignUpOpened;

  Requesting copyWith({bool? sendingOtp, bool? verifyingOtp, bool? saving, bool? checking, bool? isSignUpOpened}) {
    return Requesting(
        saving: saving ?? false,
        sendingOtp: sendingOtp ?? false,
        verifyingOtp: verifyingOtp ?? false,
        checking: checking ?? false,
        isSignUpOpened: isSignUpOpened ?? false);
  }

  @override
  List<Object?> get props => [this.verifyingOtp, this.sendingOtp, this.saving, this.checking, this.isSignUpOpened];
}

class UserAlreadyExists extends AuthState {
  final bool exist;
  UserAlreadyExists(this.exist);
  @override
  List<Object?> get props => [exist];
}

class OtpSent extends AuthState {
  final bool isAuthor;
  const OtpSent(this.isAuthor);
  @override
  List<Object?> get props => [isAuthor];
}

class OtpVerified extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthError extends AuthState {
  final String? reason;
  AuthError({this.reason});

  @override
  List<Object?> get props => [reason];
}

class AuthSuccess extends AuthState {
  final TbUserData userData;
  const AuthSuccess({required this.userData});
  @override
  List<Object?> get props => [];
}

class ReferenceCodeVerified extends AuthState {
  final ReferenceCode? referenceCode;
  ReferenceCodeVerified(this.referenceCode);

  @override
  List<Object?> get props => [referenceCode];
}

class UserAuthenticatedWithTruecaller extends AuthState {
  final TbUserData userData;
  const UserAuthenticatedWithTruecaller({required this.userData});
  @override
  List<Object?> get props => [userData];
}

class AuthErrorWithTruecaller extends AuthState {
  final String? reason;
  AuthErrorWithTruecaller({this.reason});

  @override
  List<Object?> get props => [reason];
}
