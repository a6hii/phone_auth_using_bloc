import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_demo/bloc/login_bloc.dart';
//import 'package:phone_auth_demo/blocs/bloc/phone_auth_bloc.dart';
import 'package:phone_auth_demo/screens/home_screen.dart';
import 'package:phone_auth_demo/screens/new_user_signup_screen.dart';
import 'package:phone_auth_demo/screens/select_city_screen.dart';

class OtpVerificationScreen extends StatelessWidget {
  OtpVerificationScreen({super.key});
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // bool city;
    // StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> hasCity =
    //     FirebaseFirestore.instance
    //         .collection('users')
    //         .doc(FirebaseAuth.instance.currentUser!.uid)
    //         .snapshots()
    //         .listen((event) {
    //   if (event.data()!.containsKey('City')) {
    //     city = true;
    //   } else {
    //     city = false;
    //   }
    // });
    // Future<bool> cityExists(String city) async {
    //   final QuerySnapshot result = await FirebaseFirestore.instance
    //       .collection('users')
    //       .where('City', isEqualTo: city)
    //       .limit(1)
    //       .get();
    //   final List<DocumentSnapshot> documents = result.docs;
    //   return documents.length == 1;
    // }

    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is OtpExceptionState) {
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
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Otp Verification'),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: Form(
                    child: TextField(
                  controller: _otpController,
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(10),
                  ),
                )),
              ),
              OutlinedButton(
                onPressed: () {
                  context.read<LoginBloc>().add(VerifyOtpEvent(
                        otp: _otpController.text,
                      ));
                },
                child: const Text('Verify'),
              ),
            ],
          ));
        },
      ),
    );
  }
}
