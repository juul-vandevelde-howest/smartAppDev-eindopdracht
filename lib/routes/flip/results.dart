import 'package:flip/providers/study_provider.dart';
import 'package:flip/routes/flip/decks.dart';
import 'package:flip/widgets/progressbar.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class Results extends StatelessWidget {
  const Results({super.key});

  @override
  Widget build(BuildContext context) {
    var studyProvider = Provider.of<StudyProvider>(context);
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
                      "${studyProvider.currentIndex}/${studyProvider.currentIndex}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Progressbar(value: 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
