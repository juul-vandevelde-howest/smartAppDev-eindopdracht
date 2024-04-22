import 'package:flip/routes/flip/add.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flip/routes/flip/study.dart';
import 'package:flip/widgets/progressbar.dart';

class DeckCard extends StatelessWidget {
  final String name;
  final int cardCount;
  final int learnedCount;
  final dynamic cards;

  const DeckCard({
    super.key,
    required this.name,
    required this.cardCount,
    required this.learnedCount,
    required this.cards,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation1,
                Animation<double> animation2) {
              return Study();
            },
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
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
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        cardCount == 0
                            ? "Edit to add cards"
                            : cardCount == 1
                                ? "$cardCount card"
                                : "$cardCount cards",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(8.0),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (BuildContext context,
                              Animation<double> animation1,
                              Animation<double> animation2) {
                            return Add(deckName: name, editCards: cards);
                          },
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                    child: const PhosphorIcon(
                      PhosphorIconsBold.pencilSimple,
                      size: 32.0,
                      color: Color(0xFF133266),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (cardCount != 0)
                    Progressbar(value: learnedCount / cardCount),
                  if (cardCount != 0) const SizedBox(height: 8),
                  if (cardCount != 0)
                    if (learnedCount == cardCount)
                      const Text("All cards learned"),
                  if (learnedCount != cardCount)
                    Text("$learnedCount/$cardCount cards learned"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
