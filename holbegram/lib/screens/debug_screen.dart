import 'package:flutter/material.dart';
import 'package:holbegram/screens/home.dart';
import 'package:holbegram/screens/login_screen.dart';
import 'package:holbegram/screens/signup_screen.dart';
import 'package:holbegram/screens/upload_image_screen.dart';
import 'package:holbegram/widgets/holbegram_header.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DebugScreen extends StatelessWidget {
  const DebugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      children: [
        Column(
          children: [
            const HolbegramHeader(),
            const Text('Holbegram debug screen',
                style: TextStyle(fontSize: 20)),
            Text('Username: ${FirebaseAuth.instance.currentUser?.email}'),
            Text('Auth uid: ${FirebaseAuth.instance.currentUser?.uid}'),
          ],
        ),
        Center(
          child: Column(children: [
            FilledButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen(
                                emailController: TextEditingController(),
                                passwordController: TextEditingController(),
                              )));
                },
                child: const Text('Login screen')),
            FilledButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignupScreen(
                                emailController: TextEditingController(),
                                usernameController: TextEditingController(),
                                passwordController: TextEditingController(),
                                passwordConfirmController:
                                    TextEditingController(),
                              )));
                },
                child: const Text('Signup screen')),
            FilledButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddPicture(
                              email: 'none@nomail.com',
                              password: '123',
                              username: 'John Doe',
                              image: null)));
                },
                child: const Text('Upload image screen')),
            FilledButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                child: const Text('Home screen')),
            FilledButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen(
                                emailController: TextEditingController(),
                                passwordController: TextEditingController(),
                              )));
                },
                child: const Text('Log out'))
          ]),
        )
      ],
    ));
  }
}
