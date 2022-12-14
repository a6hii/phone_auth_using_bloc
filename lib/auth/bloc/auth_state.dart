part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class InitialAuthenticationState extends AuthState {}

class Uninitialized extends AuthState {}

class Authenticated extends AuthState {}

class Unauthenticated extends AuthState {}

class Loading extends AuthState {}
