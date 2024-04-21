import 'dart:convert';

import 'package:flip/routes/flip/decks.dart';
import 'package:flip/widgets/add_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final List<Map<String, String>> _cards = [];
  String _deckName = '';

  void _updateCardsList(String term, String definition, int index) {
    setState(() {
      if (term.isEmpty && definition.isEmpty) {
        _cards.removeAt(index);
      } else {
        if (index == _cards.length) {
          _cards.add({'term': term, 'definition': definition});
        } else {
          _cards[index] = {'term': term, 'definition': definition};
        }
      }
    });
  }

  void saveDeck() async {
    if (_deckName.isEmpty && _cards.isEmpty) {
      if (mounted) {
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
      return;
    }

    var url = Uri.parse('http://10.0.2.2:3000/decks?name=$_deckName');
    var requestBody = jsonEncode(_cards);
    await http.post(url,
        body: requestBody, headers: {"Content-Type": "application/json"});

    if (mounted) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                      left: 40,
                      right: 40),
                  child: ListView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: EdgeInsets.zero,
                    children: [
                      const SizedBox(height: 55),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _deckName = value;
                          });
                        },
                        validator: (value) =>
                            value!.isEmpty ? 'Enter a deck name' : null,
                        cursorColor: const Color(0xFF133266),
                        cursorWidth: 3,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF133266),
                              width: 3,
                            ),
                          ),
                          hintText: "Type deck name here",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: Row(
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  alignment: Alignment.centerLeft),
                              onPressed: null,
                              child: const Text(
                                'Scan a document',
                                style: TextStyle(
                                  color: Color(0xFF133266),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Color(0xFF133266),
                                  decorationThickness: 2,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            TextButton(
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  alignment: Alignment.centerLeft),
                              onPressed: null,
                              child: const Text(
                                'Import deck',
                                style: TextStyle(
                                  color: Color(0xFF133266),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Color(0xFF133266),
                                  decorationThickness: 2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      for (final card in _cards) ...[
                        AddCard(
                            term: card['term']!,
                            definition: card['definition']!,
                            index: _cards.indexOf(card) + 1,
                            total: _cards.length,
                            updateFunction: _updateCardsList),
                      ],
                      AddCard(
                          total: _cards.length,
                          updateFunction: _updateCardsList),
                      const SizedBox(height: 155),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: const Color(0xFF133266),
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: () {
                    saveDeck();
                  },
                  child: Text(
                    _cards.isEmpty && _deckName == '' ? 'Go back' : 'Save deck',
                    style: const TextStyle(
                      color: Color(0xFF133266),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
