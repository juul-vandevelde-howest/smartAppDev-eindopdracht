import 'package:flutter/material.dart';
import 'package:flip/routes/flip/flip_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String password = '';

  void login() async {
    if (email.isNotEmpty || password.isNotEmpty) {
      print(email);
      print(password);
    }

    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        log('User ${credential.user} logged in');
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const FlipNavigation(),
            ),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("We couldn't find an account with that username.");
      } else if (e.code == 'wrong-password') {
        print('Your account or password is incorrect.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome back!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  const Text(
                    'Login below or ',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Add code to navigate to the create account screen
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.zero,
                      ),
                    ),
                    child: const Text(
                      'create an account',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF133266),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: const Border(
                    top: BorderSide(
                      color: Color(0xFF133266),
                      width: 4.0,
                    ),
                    bottom: BorderSide(
                      color: Color(0xFF133266),
                      width: 8.0,
                    ),
                    left: BorderSide(
                      color: Color(0xFF133266),
                      width: 4.0,
                    ),
                    right: BorderSide(
                      color: Color(0xFF133266),
                      width: 4.0,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: const Border(
                    top: BorderSide(
                      color: Color(0xFF133266),
                      width: 4.0,
                    ),
                    bottom: BorderSide(
                      color: Color(0xFF133266),
                      width: 8.0,
                    ),
                    left: BorderSide(
                      color: Color(0xFF133266),
                      width: 4.0,
                    ),
                    right: BorderSide(
                      color: Color(0xFF133266),
                      width: 4.0,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Enter your password',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF133266),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: login,
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      // Add code to navigate to the forgot password screen
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.zero,
                      ),
                    ),
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF133266),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
