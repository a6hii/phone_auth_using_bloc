part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class InitialLoginState extends LoginState {}

class OtpSentState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class OtpVerifiedState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginCompleteState extends LoginState {
  final User? _firebaseUser;

  const LoginCompleteState(this._firebaseUser);

  User? getUser() {
    return _firebaseUser;
  }

  @override
  List<Object?> get props => [_firebaseUser];
}

class ExceptionState extends LoginState {
  final String message;

  const ExceptionState({required this.message});

  @override
  List<Object> get props => [message];
}

class OtpExceptionState extends LoginState {
  final String message;

  const OtpExceptionState({required this.message});

  @override
  List<Object> get props => [message];
}
