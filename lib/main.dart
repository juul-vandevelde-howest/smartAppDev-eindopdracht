import 'package:flutter/material.dart';
import 'package:flip/firebase_options.dart';
import 'package:flip/routes/auth/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flip/providers/study_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => StudyProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flip',
      debugShowCheckedModeBanner: false,
      home: const Login(),
      theme: ThemeData(
        fontFamily: 'Poppins',
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Poppins',
              bodyColor: const Color(0xFF133266),
              displayColor: const Color(0xFF133266),
            ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFF133266),
          selectionColor: Color(0xFFA5DAE3),
          selectionHandleColor: Color(0xFFA5DAE3),
        ),
      ),
    );
  }
}
