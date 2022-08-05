import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth_demo/auth/bloc/auth_bloc.dart';
import 'package:phone_auth_demo/bloc/login_bloc.dart';

import 'package:phone_auth_demo/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:phone_auth_demo/repo/user_repo.dart';
import 'package:phone_auth_demo/screens/home_screen.dart';
import 'package:phone_auth_demo/screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  UserRepository userRepository = UserRepository();
  runApp(
    //connect firebase.

    MyApp(
      userRepository: userRepository,
    ),
  );
}

class MyApp extends StatelessWidget {
  final UserRepository _userRepository;
  const MyApp({
    Key? key,
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(_userRepository)..add(AppStarted()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(userRepository: _userRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Uninitialized) {
              return CircularProgressIndicator();
            } else if (state is Unauthenticated) {
              return LoginScreen();
            } else if (state is Authenticated) {
              return HomeScreen();
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<PhoneAuthBloc, PhoneAuthState>(
//       listener: (context, state) {
//         if (state is PhoneAuthError) {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (_) => LoginScreen(),
//             ),
//           );
//         }
//       },
//       builder: (context, state) {
//         if (state is PhoneAuthInitial) {
//           Future.delayed(Duration.zero, () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => LoginScreen(),
//               ),
//             );
//           });
//         } else if (state is PhoneAuthLoading) {
//           return const CircularProgressIndicator();
//         } else if (state is PhoneAuthCodeVerificationSuccess) {
//           return const HomeScreen();
//         } else {
//           return const Scaffold(
//             body: CircularProgressIndicator(),
//           );
//         }
//         return Container();
//       },
//     );
//   }
// }
