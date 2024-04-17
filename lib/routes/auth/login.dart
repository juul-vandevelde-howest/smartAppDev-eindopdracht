import 'package:flutter/material.dart';
import 'package:flip/routes/flip/flip_navigation.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    void onPressed() {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const FlipNavigation(),
          ),
        );
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Center(
            child: TextButton(
          onPressed: onPressed,
          child: const Text('Login'),
        )),
      ),
    );
  }
}
