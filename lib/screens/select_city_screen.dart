import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth_demo/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectCityScreen extends StatelessWidget {
  const SelectCityScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('Select City'),
          OutlinedButton(
            onPressed: () async {
              final uid = FirebaseAuth.instance.currentUser!.uid;
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .update({
                'city': 'Patna',
              });
              Future.delayed(Duration.zero, () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => const HomeScreen(),
                ));
              });
            }, //goes to homepage where we load the venues only in that the city
            child: const Text('Patna'),
          ),
          OutlinedButton(
            onPressed: () async {
              final uid = FirebaseAuth.instance.currentUser!.uid;
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .update({
                'city': 'Delhi',
              });
              Future.delayed(Duration.zero, () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => const HomeScreen(),
                ));
              });
            },
            child: const Text('Delhi'),
          ),
        ]),
      ),
    );
  }
}
