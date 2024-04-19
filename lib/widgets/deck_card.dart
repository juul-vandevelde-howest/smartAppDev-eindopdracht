import 'package:flip/routes/flip/add.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flip/routes/flip/study.dart';
import 'package:flip/widgets/progressbar.dart';

class DeckCard extends StatelessWidget {
  const DeckCard({
    super.key,
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
              return const Study();
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
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deck Name',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '10 cards',
                        style: TextStyle(
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
                            return const Add();
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
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Progressbar(value: 0.9),
                  SizedBox(height: 8),
                  Text("9/10 cards learned"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
