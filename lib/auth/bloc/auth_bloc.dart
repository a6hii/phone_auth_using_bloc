import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:phone_auth_demo/repo/user_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;
  AuthBloc(this.userRepository) : super(InitialAuthenticationState()) {
    on<AppStarted>((event, emit) async {
      final bool hasToken = await userRepository.getUser() != null;

      if (hasToken) {
        emit(Loading());
        emit(Authenticated());
      } else {
        emit(Loading());
        emit(Unauthenticated());
      }
    });
    on<LoggedIn>((event, emit) {
      emit(Loading());
      emit(Authenticated());
    });
    on<LoggedOut>((event, emit) {
      emit(Loading());
      emit(Unauthenticated());
    });
  }
}
