import 'dart:convert';

import 'package:flip/routes/flip/add.dart';
import 'package:flip/routes/flip/settings.dart';
import 'package:flip/widgets/deck_card.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:http/http.dart' as http;

class Decks extends StatefulWidget {
  const Decks({super.key});

  @override
  State<Decks> createState() => _DecksState();
}

class _DecksState extends State<Decks> {
  Map<String, List<int>> deckData = {
    'loading': [0, 0]
  };
  Map<String, List<int>> filteredDeckData = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:3000/decks'));
      if (response.statusCode == 200) {
        final List<dynamic> decks = jsonDecode(response.body);
        Map<String, List<int>> updatedDeckData = {};
        for (var deck in decks) {
          String deckName = deck['name'];
          if (deckName.isEmpty) {
            deckName = '(Draft) Untitled deck';
          }
          if (updatedDeckData.containsKey(deckName)) {
            int counter = 1;
            String originalDeckName = deckName;
            while (updatedDeckData.containsKey(deckName)) {
              deckName = '$originalDeckName $counter';
              counter++;
            }
          }
          int cardCount = deck['cards'].length;
          int learnedCount =
              deck['cards'].where((card) => card['studied'] == true).length;
          updatedDeckData[deckName] = [cardCount, learnedCount];
        }
        setState(() {
          print(updatedDeckData);
          deckData = updatedDeckData;
          filteredDeckData = updatedDeckData;
        });
      } else {
        // TODO: show the user an error message
      }
    } catch (e) {
      // TODO: show the user an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top, left: 40, right: 40),
            child: Padding(
              padding: const EdgeInsets.only(top: 55),
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: SearchBar(
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty) {
                    // if the search query is empty, display all decks
                    filteredDeckData = Map.from(deckData);
                  } else {
                    // filter the decks based on search input
                    filteredDeckData = {};
                    deckData.forEach((key, list) {
                      if (key.toLowerCase().contains(value.toLowerCase())) {
                        filteredDeckData[key] = list;
                      }
                    });
                  }
                });
              },
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
              hintText: 'Search for a deck',
              side: MaterialStateProperty.all(
                  const BorderSide(color: Color(0xFF133266), width: 3)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: deckData.isNotEmpty && deckData.keys.first == "loading"
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF133266),
                      ),
                    )
                  : deckData.isEmpty
                      ? const Center(
                          child: Text(
                            'No decks found.\nAdd a deck to get started.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : ListView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          padding: EdgeInsets.zero,
                          children: filteredDeckData.keys
                              .map(
                                (deckName) => DeckCard(
                                  name: deckName,
                                  cardCount: filteredDeckData[deckName]
                                          ?.elementAt(0) ??
                                      0,
                                  learnedCount: filteredDeckData[deckName]
                                          ?.elementAt(1) ??
                                      0,
                                ),
                              )
                              .toList(),
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
