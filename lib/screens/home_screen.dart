import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_demo/blocs/bloc/phone_auth_bloc.dart';
import 'package:phone_auth_demo/screens/login_screen.dart';
import 'package:phone_auth_demo/widgets/generic_dialog.dart';

enum MenuAction { logout }

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Logout',
    content: 'Do you want to logout?',
    optionsBuilder: () => {
      'cancel': false,
      'Confirm Logout': true,
    },
  ).then(
    (value) => value ?? false,
  );
}

class HomeScreen extends StatelessWidget {
  //final String city;
  const HomeScreen({
    super.key,
    //required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    context.read<PhoneAuthBloc>().add(
                          PhoneAuthLoggedOut(),
                        );
                  }
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Logout'),
                ),
              ];
            },
          )
        ],
      ),
      body: BlocConsumer<PhoneAuthBloc, PhoneAuthState>(
        listener: (context, state) {
          if (state is PhoneAuthInitial) {
            Future.delayed(Duration.zero, () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => LoginScreen(),
              ));
            });
          }
        },
        builder: (context, state) {
          if (state is PhoneAuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ElevatedButton(
              //   onPressed: () {
              //     context.read<PhoneAuthBloc>().add(
              //           PhoneAuthLoggedOut(),
              //         );
              //   },
              //   child: const Text(
              //     'Logout',
              //     style: TextStyle(color: Colors.black),
              //   ),
              // ),
              Text('Home'),
            ],
          ));
        },
      ),
    );
  }
}
