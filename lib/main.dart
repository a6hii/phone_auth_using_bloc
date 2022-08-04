import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth_demo/blocs/bloc/phone_auth_bloc.dart';
import 'package:phone_auth_demo/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_demo/providers/phone_auth_provider.dart';
import 'package:phone_auth_demo/repo/phone_auth_repo.dart';
import 'package:phone_auth_demo/screens/home_screen.dart';
import 'package:phone_auth_demo/screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    //connect firebase.

    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneAuthBloc(
        phoneAuthRepository: PhoneAuthRepository(
          phoneAuthFirebaseProvider: PhoneAuthFirebaseProvider(
            firebaseAuth: FirebaseAuth.instance,
          ),
        ),
      ),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhoneAuthBloc, PhoneAuthState>(
      listener: (context, state) {
        if (state is PhoneAuthError) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => LoginScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is PhoneAuthInitial) {
          Future.delayed(Duration.zero, () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => LoginScreen(),
              ),
            );
          });
        } else if (state is PhoneAuthLoading) {
          return const CircularProgressIndicator();
        } else if (state is PhoneAuthCodeVerificationSuccess) {
          return const HomeScreen();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
        return Container();
      },
    );
  }
}
