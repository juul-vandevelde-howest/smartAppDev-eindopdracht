import 'package:flutter/material.dart';

class Study extends StatelessWidget {
  const Study({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Study'),
        ),
        body: const Center(
          child: Text("Woohow t werkt!"),
        ),
      ),
    );
  }
}
