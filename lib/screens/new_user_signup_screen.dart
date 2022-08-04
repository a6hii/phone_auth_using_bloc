import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth_demo/screens/select_city_screen.dart';

class NewUserSignupScreen extends StatelessWidget {
  NewUserSignupScreen({super.key});
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sign up'),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _nameController,
                maxLength: 25,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'enter name',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _emailController,
                maxLength: 40,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'enter email',
                ),
              ),
            ),
            OutlinedButton(
              onPressed: () async {
                await FirebaseAuth.instance.currentUser!
                    .updateDisplayName(_nameController.text);
                await FirebaseAuth.instance.currentUser!
                    .updateEmail(_emailController.text);
                final uid = FirebaseAuth.instance.currentUser!.uid;
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(uid)
                    .update({
                  'name': _nameController.text,
                  'email': _emailController.text,
                });
                Future.delayed(Duration.zero, () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Saved.'),
                      elevation: 2,
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(24),
                      backgroundColor: Colors.blue,
                    ),
                  );
                });
                Future.delayed(Duration.zero, () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => SelectCityScreen(),
                  ));
                });
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
