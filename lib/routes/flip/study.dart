import 'package:flip/routes/flip/decks.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Study extends StatelessWidget {
  const Study({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    const Text(
                      "2/25",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SizedBox(
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
                        value: 0.08,
                        minHeight: 4,
                        color: Colors.white,
                        backgroundColor: const Color(0xFF133266),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
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
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Text(
                          "1 still learning",
                          style: TextStyle(
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
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Text(
                          "0 known",
                          style: TextStyle(
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
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
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
                    ),
                    child: const Center(
                      child: Text(
                        "Bonjour",
                        style: TextStyle(
                          color: Color(0xFF133266),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    "Tap the card to flip it",
                    style: TextStyle(
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
