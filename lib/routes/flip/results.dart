import 'package:flutter/material.dart';

class Results extends StatelessWidget {
  const Results({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            textAlign: TextAlign.center,
            'Same header as study screen (prev screen) with x, progress and x/x',
            style: TextStyle(fontSize: 24),
          ),
          Text(
            textAlign: TextAlign.center,
            'Some motivational message here!',
            style: TextStyle(fontSize: 24),
          ),
          Text(
            textAlign: TextAlign.center,
            'You got 5 out of 10 questions right! (show study stats)',
            style: TextStyle(fontSize: 24),
          ),
          TextButton(
            onPressed: null,
            child: Text('Continue learning / Restart Deck'),
          ),
          TextButton(
            onPressed: null,
            child: Text('Return to your decks'),
          ),
        ],
      ),
    );
  }
}
