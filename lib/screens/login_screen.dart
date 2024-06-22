import 'package:flutter/material.dart';
import 'package:holbegram/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool _passwordVisible;

  const LoginScreen({
    super.key,
    required this.emailController,
    required this.passwordController,
    bool passwordVisible = true,
  }) : _passwordVisible = passwordVisible;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = true;

  @override
  void initState() {
    passwordVisible = widget._passwordVisible;
    super.initState();
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
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(children: [
                SizedBox(
                    height: 64,
                    child: TextFieldInput(
                      controller: widget.emailController,
                      hintText: 'Email',
                      isPassword: false,
                      keyboardType: TextInputType.emailAddress,
                    )),
                SizedBox(
                    height: 64,
                    child: TextFieldInput(
                      controller: widget.passwordController,
                      isPassword: !passwordVisible,
                      hintText: 'Password',
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: IconButton(
                        alignment: Alignment.centerLeft,
                        icon: Icon(passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () =>
                            setState(() => passwordVisible = !passwordVisible),
                      ),
                    )),
                SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(218, 226, 37, 24),
                        ),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                const SizedBox(
                    height: 58,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Forgot your login details? "),
                          Text("Get help logging in",
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ])),
                const Flexible(
                  flex: 0,
                  child: SizedBox(
                    height: 34,
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(218, 226, 37, 24),
                            ),
                          ),
                        )
                      ],
                    )),
                const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(child: Divider(thickness: 2)),
                      Flexible(
                        child: Text(" OR "),
                      ),
                      Flexible(child: Divider(thickness: 2)),
                      ]),
                SizedBox(
                    height: 40,
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png',
                            height: 40,
                            width: 40,
                          ),
                          const Text("Sign in with Google")
                        ]))
              ]))
        ],
      )),
    );
  }
}
