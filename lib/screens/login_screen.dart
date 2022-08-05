import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_demo/auth/bloc/auth_bloc.dart';
import 'package:phone_auth_demo/bloc/login_bloc.dart';
//import 'package:phone_auth_demo/blocs/bloc/phone_auth_bloc.dart';
import 'package:phone_auth_demo/screens/otp_verification_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
      if (state is ExceptionState) {
        String message = state.message;

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(message), const Icon(Icons.error)],
              ),
              backgroundColor: Colors.red,
            ),
          );
      }
    }, builder: (context, state) {
      //   if (state is PhoneAuthInitial) {

      //   } else if (state is PhoneAuthLoading) {
      //     return const Center(child: CircularProgressIndicator());
      //   }
      //   return Container();
      // },

      if (state is Unauthenticated) {
        return Scaffold(
          body: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                    child: TextField(
                  controller: _phoneNumberController,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    fillColor: Colors.yellow,
                  ),
                )),
              ),
              OutlinedButton(
                onPressed: () {
                  BlocProvider.of<LoginBloc>(context).add(
                      SendOtpEvent(phoNo: '+91${_phoneNumberController.text}'));
                },
                child: const Text('Login/SignUp'),
              ),
            ],
          )),
        );
      } else if (state is OtpSentState || state is OtpExceptionState) {
        return OtpVerificationScreen();
      } else if (state is LoadingState) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is LoginCompleteState) {
        BlocProvider.of<AuthBloc>(context)
            .add(LoggedIn(token: state.getUser()!.uid));
      }
      return Scaffold(
        backgroundColor: Colors.yellow,
        body: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                  child: TextField(
                controller: _phoneNumberController,
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.yellow,
                ),
              )),
            ),
            OutlinedButton(
              onPressed: () {
                BlocProvider.of<LoginBloc>(context).add(
                    SendOtpEvent(phoNo: '+91${_phoneNumberController.text}'));
              },
              child: const Text('Login/SignUp'),
            ),
          ],
        )),
      );
    });
  }
}
