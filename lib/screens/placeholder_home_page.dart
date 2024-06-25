import 'package:flutter/material.dart';
import 'package:holbegram/screens/login_screen.dart';
import 'package:holbegram/screens/signup_screen.dart';
import 'package:holbegram/widgets/holbegram_header.dart';

class PlaceholderHomePage extends StatelessWidget {
  const PlaceholderHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      children: [
        const Column(
          children: [
            HolbegramHeader(),
            Text('Holbegram placeholder home', style: TextStyle(fontSize: 20))
          ],
        ),
        Center(
          child: Column(children: [
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
                child: const Text('Login screen')),
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
                child: const Text('Signup screen'))
          ]),
        )
      ],
    ));
  }
}
