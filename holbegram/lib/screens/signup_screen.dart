import 'package:flutter/material.dart';
import 'package:holbegram/widgets/text_field.dart';
import 'package:holbegram/screens/login_screen.dart';
import 'package:holbegram/screens/upload_image_screen.dart';

class SignupScreen extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;
  final bool _passwordVisible;

  const SignupScreen({
    super.key,
    required this.emailController,
    required this.usernameController,
    required this.passwordController,
    required this.passwordConfirmController,
    bool passwordVisible = true,
  }) : _passwordVisible = passwordVisible;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool passwordVisible = true;

  @override
  void initState() {
    passwordVisible = widget._passwordVisible;
    super.initState();
  }

  @override
  void dispose() {
    widget.emailController.dispose();
    widget.usernameController.dispose();
    widget.passwordController.dispose();
    widget.passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Column(
              children: [
                const SizedBox(
                  height: 78,
                  child: Text(
                    "Holbegram",
                    style: TextStyle(
                      fontFamily: 'Billabong',
                      fontSize: 50,
                    ),
                  ),
                ),
                const SizedBox(
                    height: 80,
                    child: Image(
                      height: 60,
                      width: 80,
                      image: AssetImage('assets/images/logo.webp'),
                    )),
                const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign up to see photos and videos from your friends.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 83, 83, 83),
                          fontWeight: FontWeight.w400),
                    )),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFieldInput(
                    controller: widget.emailController,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFieldInput(
                    controller: widget.usernameController,
                    hintText: 'Full Name',
                    keyboardType: TextInputType.text,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFieldInput(
                    controller: widget.passwordController,
                    hintText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: !passwordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFieldInput(
                    controller: widget.passwordConfirmController,
                    hintText: 'Confirm Password',
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: !passwordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                            const Color.fromARGB(218, 226, 37, 24),
                          ),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddPicture(
                                email: widget.emailController.text,
                                username: widget.usernameController.text,
                                password: widget.passwordController.text),
                          ));
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ),
                Divider(
                  color: Colors.grey.shade400,
                ),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Have an account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginScreen(
                                emailController: TextEditingController(),
                                passwordController: TextEditingController(),
                              ),
                            ));
                          },
                          child: const Text('Log in',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(218, 226, 37, 24))),
                        ),
                      ],
                    ))
              ],
            )),
          ],
        ),
      ),
    );
  }
}
