import 'package:flip/routes/flip/decks.dart';
import 'package:flip/widgets/progressbar.dart';
import 'package:flip/widgets/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flip/providers/study_provider.dart';

class Study extends StatefulWidget {
  final String deckId;
  final dynamic deckData;
  const Study({super.key, required this.deckId, required this.deckData});

  @override
  State<Study> createState() => _StudyState();
}

class _StudyState extends State<Study> {
  late List<FlipCard> cards;
  late int cardsLength;
  int currentIndex = 1;

  @override
  void initState() {
    super.initState();
    cards = widget.deckData
        .where((card) => card['studied'] == false)
        .map((card) => FlipCard(front: card['term'], back: card['definition']))
        .toList()
        .cast<FlipCard>();
    cards.shuffle();
    cardsLength = cards.length;
  }

  @override
  Widget build(BuildContext context) {
    var studyProvider = Provider.of<StudyProvider>(context);

    if (studyProvider.totalCards != cardsLength) {
      Future.delayed(Duration.zero, () {
        studyProvider.setTotalCards(cardsLength);
      });
    }

    if (studyProvider.currentIndex != currentIndex) {
      currentIndex = studyProvider.currentIndex;
      cards.removeLast();
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
                    Text(
                      "${studyProvider.currentIndex}/$cardsLength",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Progressbar(
                      value: studyProvider.currentIndex / cardsLength),
                ),
                Row(
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Stack(
                    alignment: Alignment.center,
                    children: cards,
                  ),
                ),
                Center(
                  child: Text(
                    studyProvider.flipped
                        ? "Swipe left to mark as Still Learning\nSwipe right to mark as Known"
                        : "Tap the card to flip it",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF133266),
                      fontSize: 16,
                    ),
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
