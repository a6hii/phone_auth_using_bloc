part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class SendOtpEvent extends LoginEvent {
  final String phoNo;

  const SendOtpEvent({required this.phoNo});
}

class AppStartEvent extends LoginEvent {}

class VerifyOtpEvent extends LoginEvent {
  final String otp;

  const VerifyOtpEvent({required this.otp});
}

class LogoutEvent extends LoginEvent {}

class OtpSendEvent extends LoginEvent {}

class LoginCompleteEvent extends LoginEvent {
  final User? firebaseUser;
  const LoginCompleteEvent(this.firebaseUser);
}

class LoginExceptionEvent extends LoginEvent {
  final String message;

  const LoginExceptionEvent(this.message);
}
