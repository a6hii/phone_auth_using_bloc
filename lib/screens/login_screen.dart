import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_demo/blocs/bloc/phone_auth_bloc.dart';
import 'package:phone_auth_demo/screens/otp_verification_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PhoneAuthBloc, PhoneAuthState>(
        listener: (context, state) {
          if (state is PhoneAuthCodeSentSuccess) {
            Future.delayed(Duration.zero, () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => OtpVerificationScreen(),
              ));
            });
          } else if (state is PhoneAuthNumberVerficationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              elevation: 2,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(24),
              backgroundColor: Colors.blue,
            ));
          } else if (state is PhoneAuthNumberVerificationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('OTP sent'),
              elevation: 2,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(24),
              backgroundColor: Colors.blue,
            ));
          }
        },
        builder: (context, state) {
          if (state is PhoneAuthInitial) {
            return Center(
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
                    BlocProvider.of<PhoneAuthBloc>(context).add(
                        PhoneAuthNumberVerified(
                            phoneNumber: '+91${_phoneNumberController.text}'));
                  },
                  child: const Text('Login/SignUp'),
                ),
              ],
            ));
          } else if (state is PhoneAuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Container();
        },
      ),
    );
  }
}
