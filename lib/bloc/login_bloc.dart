import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_demo/repo/user_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;
  StreamSubscription? subscription;

  String verID = "";
  LoginBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(InitialLoginState()) {
    on<SendOtpEvent>((event, emit) {
      emit(LoadingState());

      subscription = sendOtp(event.phoNo).listen((event) {
        add(event);
      });
    });

    on<VerifyOtpEvent>((event, emit) async {
      emit(LoadingState());
      try {
        UserCredential result =
            await _userRepository.verifyAndLogin(verID, event.otp);
        if (result.user != null) {
          emit(LoginCompleteState(result.user));
        } else {
          emit(const OtpExceptionState(message: "Invalid otp!"));
        }
      } catch (e) {
        emit(const OtpExceptionState(message: "Invalid otp!"));
        print(e);
      }
    });

    on<OtpSendEvent>((event, emit) {
      emit(OtpSentState());
    });
    on<LoginCompleteEvent>((event, emit) {
      emit(LoginCompleteState(event.firebaseUser));
    });
    on<LoginExceptionEvent>((event, emit) {
      emit(ExceptionState(message: event.message));
    });
  }
  Stream<LoginEvent> sendOtp(String phoNo) async* {
    StreamController<LoginEvent> eventStream = StreamController();
    phoneVerificationCompleted(AuthCredential authCredential) {
      _userRepository.getUser();
      _userRepository.getUser().catchError((onError) {
        print(onError);
      }).then((user) {
        eventStream.add(LoginCompleteEvent(user));
        eventStream.close();
      });
    }

    phoneVerificationFailed(FirebaseAuthException authException) {
      print(authException.message);
      eventStream.add(LoginExceptionEvent(onError.toString()));
      eventStream.close();
    }

    phoneCodeSent(String verId, [int? forceResent]) {
      verID = verId;
      eventStream.add(OtpSendEvent());
      eventStream.close();
    }

    phoneCodeAutoRetrievalTimeout(String verid) {
      verID = verid;
      eventStream.close();
    }

    await _userRepository.sendOtp(
        phoNo,
        const Duration(seconds: 1),
        phoneVerificationFailed,
        phoneVerificationCompleted,
        phoneCodeSent,
        phoneCodeAutoRetrievalTimeout);

    yield* eventStream.stream;
  }
}
