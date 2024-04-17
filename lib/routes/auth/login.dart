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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: 'Enter your email',
                    labelText: 'Email',
                  ),
                  onChanged: (value) {
                    email = value;
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email address';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.password),
                    hintText: 'Enter your password',
                    labelText: 'Password',
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                ),
                ElevatedButton(
                  onPressed: login,
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
