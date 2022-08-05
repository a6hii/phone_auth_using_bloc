part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {
  @override
  String toString() => 'AppStarted';

  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthEvent {
  final String token;

  const LoggedIn({required this.token}) : super();

  @override
  String toString() => 'LoggedIn { token: $token }';

  @override
  List<Object> get props => [token];
}

class LoggedOut extends AuthEvent {
  @override
  String toString() => 'LoggedOut';

  @override
  List<Object> get props => [];
}
