import 'dart:convert';

import 'package:flip/providers/study_provider.dart';
import 'package:flip/routes/flip/decks.dart';
import 'package:flip/routes/flip/study.dart';
import 'package:flip/widgets/progressbar.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Results extends StatelessWidget {
  const Results({super.key});

  @override
  Widget build(BuildContext context) {
    var studyProvider = Provider.of<StudyProvider>(context);

    goToDecks() {
      studyProvider.reset();
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation1,
              Animation<double> animation2) {
            return const Decks();
          },
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    }

    continueDeck() async {
      var url = Uri.parse('http://10.0.2.2:3000/decks/${studyProvider.deckId}');
      final response =
          await http.get(url, headers: {"Content-Type": "application/json"});
      final Map<String, dynamic> deckData = jsonDecode(response.body);
      studyProvider.reset();
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation1,
              Animation<double> animation2) {
            return Study(
              deckId: deckData['id'],
              deckData: deckData['cards'],
            );
          },
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    }

    restartDeck() async {
      var url =
          Uri.parse('http://10.0.2.2:3000/decks/${studyProvider.deckId}/reset');
      final response =
          await http.put(url, headers: {"Content-Type": "application/json"});
      final Map<String, dynamic> deckData = jsonDecode(response.body);
      studyProvider.reset();
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation1,
              Animation<double> animation2) {
            return Study(
              deckId: deckData['id'],
              deckData: deckData['cards'],
            );
          },
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 40, right: 40),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(8.0),
                      onTap: () {
                        studyProvider.reset();
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (BuildContext context,
                                Animation<double> animation1,
                                Animation<double> animation2) {
                              return const Decks();
                            },
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      },
                      child: const PhosphorIcon(
                        PhosphorIconsBold.x,
                        size: 32.0,
                        color: Color(0xFF133266),
                      ),
                    ),
                    if (studyProvider.learningCount + studyProvider.knownCount >
                        0)
                      Text(
                        "${studyProvider.currentIndex}/${studyProvider.currentIndex}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                  ],
                ),
                studyProvider.learningCount + studyProvider.knownCount > 0
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Progressbar(value: 1),
                      )
                    : const SizedBox(height: 40),
                studyProvider.learningCount + studyProvider.knownCount > 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: const Color(0xFF133266),
                                width: 4,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Text(
                                "${studyProvider.learningCount} still learning",
                                style: const TextStyle(
                                  color: Color(0xFF133266),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: const Color(0xFF133266),
                                width: 4,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Text(
                                "${studyProvider.knownCount} known",
                                style: const TextStyle(
                                  color: Color(0xFF133266),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(height: 16),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.72,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 0),
                      Text(
                        (studyProvider.learningCount +
                                    studyProvider.knownCount ==
                                0)
                            ? "You've already mastered all the terms."
                            : (studyProvider.knownCount ==
                                    studyProvider.totalCards
                                ? "Congratulations! You've mastered all the terms."
                                : "You are doing brilliantly! Keep focussing on the tough terms."),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xFF133266),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextButton(
                              onPressed: () {
                                studyProvider.knownCount ==
                                            studyProvider.totalCards ||
                                        studyProvider.learningCount +
                                                studyProvider.knownCount ==
                                            0
                                    ? restartDeck()
                                    : continueDeck();
                              },
                              child: Text(
                                studyProvider.knownCount ==
                                            studyProvider.totalCards ||
                                        studyProvider.learningCount +
                                                studyProvider.knownCount ==
                                            0
                                    ? 'Restart Deck'
                                    : 'Keep Studying',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              studyProvider.knownCount ==
                                          studyProvider.totalCards ||
                                      studyProvider.learningCount +
                                              studyProvider.knownCount ==
                                          0
                                  ? goToDecks()
                                  : restartDeck();
                            },
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.zero,
                              ),
                            ),
                            child: Text(
                              studyProvider.knownCount ==
                                          studyProvider.totalCards ||
                                      studyProvider.learningCount +
                                              studyProvider.knownCount ==
                                          0
                                  ? 'Go back to Decks'
                                  : 'Restart Deck',
                              style: const TextStyle(
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
