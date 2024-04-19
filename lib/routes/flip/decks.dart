import 'package:flip/routes/flip/add.dart';
import 'package:flip/routes/flip/settings.dart';
import 'package:flip/routes/flip/study.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Decks extends StatelessWidget {
  const Decks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 40, right: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Decks",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
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
                          return const Settings();
                        },
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
                  child: const PhosphorIcon(
                    PhosphorIconsBold.slidersHorizontal,
                    size: 32.0,
                    color: Color(0xFF133266),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 40, right: 40),
            child: SearchBar(
              textStyle: MaterialStateProperty.resolveWith(
                  (states) => const TextStyle(color: Color(0xFF133266))),
              surfaceTintColor:
                  MaterialStateProperty.resolveWith((states) => Colors.white),
              shadowColor: MaterialStateProperty.resolveWith(
                  (states) => Colors.transparent),
              leading: const Padding(
                padding: EdgeInsets.all(10.0),
                child: PhosphorIcon(PhosphorIconsBold.magnifyingGlass,
                    size: 24.0, color: Color(0xFF133266)),
              ),
              hintText: 'Search for a deck or word',
              side: MaterialStateProperty.all(
                  const BorderSide(color: Color(0xFF133266), width: 3)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (BuildContext context,
                              Animation<double> animation1,
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
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
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
                                PhosphorIcon(
                                  PhosphorIconsBold.pencilSimple,
                                  size: 32.0,
                                  color: Color(0xFF133266),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF133266),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: const Color(0xFF133266),
                                        width: 5,
                                      ),
                                    ),
                                    child: LinearProgressIndicator(
                                      value: 0.9,
                                      minHeight: 4,
                                      color: Colors.white,
                                      backgroundColor: const Color(0xFF133266),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text("9/10 cards learned"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: const Color(0xFF133266),
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: () {
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
                  child: const Text(
                    'Add Deck',
                    style: TextStyle(
                      color: Color(0xFF133266),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
