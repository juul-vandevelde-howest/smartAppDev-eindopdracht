import 'dart:convert';
import 'package:flip/routes/flip/decks.dart';
import 'package:flip/routes/flip/scan.dart';
import 'package:flip/widgets/add_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Add extends StatefulWidget {
  final dynamic deckName;
  final dynamic editCards;
  final dynamic deckId;
  const Add({super.key, this.deckName, this.editCards, this.deckId});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final List<Map<String, String>> _cards = [];
  String _deckName = '';
  bool isEdited = false;

  @override
  void initState() {
    super.initState();
    if (widget.editCards != null) {
      for (final card in widget.editCards) {
        _cards.add({'term': card['term'], 'definition': card['definition']});
      }
    }
    if (widget.deckName != null) {
      _deckName = widget.deckName;
    }
  }

  void _updateCardsList(String term, String definition, int index) {
    setState(() {
      isEdited = true;
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
    if (widget.deckId != null && widget.deckId.isNotEmpty) {
      if (!isEdited) {
        // If editCards is not empty and isEdited is false, go back
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
      } else {
        // If editCards is not empty and isEdited is true, save changes
        FirebaseAuth auth = FirebaseAuth.instance;
        String? idToken = await auth.currentUser?.getIdToken();
        var url = Uri.parse(
            'http://10.0.2.2:3000/decks/${widget.deckId}?name=$_deckName');
        var requestBody = jsonEncode(_cards);
        await http.put(
          url,
          body: requestBody,
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $idToken',
          },
        );
      }
    } else if (_deckName.isEmpty && _cards.isEmpty) {
      // If editCards is empty and both _deckName and _cards are empty, go back
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
    } else {
      // If editCards is empty and either _deckName or _cards is not empty, save deck
      FirebaseAuth auth = FirebaseAuth.instance;
      String? idToken = await auth.currentUser?.getIdToken();
      var url = Uri.parse('http://10.0.2.2:3000/decks?name=$_deckName');
      var requestBody = jsonEncode(_cards);
      await http.post(url, body: requestBody, headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $idToken',
      });
    }

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
                      widget.deckId != null && widget.deckId.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    borderRadius: BorderRadius.circular(8.0),
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            title: const Text(
                                              'Delete deck?',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            content: const Text(
                                              'This action cannot be undone. Are you sure you want to delete this deck?',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                    color: Color(0xFF133266),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xFF661332),
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  FirebaseAuth auth =
                                                      FirebaseAuth.instance;
                                                  String? idToken = await auth
                                                      .currentUser
                                                      ?.getIdToken();
                                                  var url = Uri.parse(
                                                      'http://10.0.2.2:3000/decks/${widget.deckId}');
                                                  await http
                                                      .delete(url, headers: {
                                                    "Content-Type":
                                                        "application/json",
                                                    'Authorization':
                                                        'Bearer $idToken',
                                                  });
                                                  Future.delayed(Duration.zero,
                                                      () {
                                                    Navigator.pushReplacement(
                                                      context,
                                                      PageRouteBuilder(
                                                        pageBuilder:
                                                            (_, __, ___) =>
                                                                const Decks(),
                                                        transitionDuration:
                                                            Duration.zero,
                                                        reverseTransitionDuration:
                                                            Duration.zero,
                                                      ),
                                                    );
                                                  });
                                                },
                                                child: const Text('Delete',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    )),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: const PhosphorIcon(
                                      PhosphorIconsBold.trash,
                                      size: 32.0,
                                      color: Color(0xFF661332),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(height: 55),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            isEdited = true;
                            _deckName = value;
                          });
                        },
                        initialValue: widget.deckName,
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
                        child: widget.editCards == null ||
                                widget.editCards.isEmpty
                            ? Row(
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      alignment: Alignment.centerLeft,
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (BuildContext context,
                                              Animation<double> animation1,
                                              Animation<double> animation2) {
                                            return const Scan();
                                          },
                                          transitionDuration: Duration.zero,
                                          reverseTransitionDuration:
                                              Duration.zero,
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Scan a document (beta)',
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
                                  // const SizedBox(width: 20),
                                  // TextButton(
                                  //   style: TextButton.styleFrom(
                                  //     padding: EdgeInsets.zero,
                                  //     tapTargetSize:
                                  //         MaterialTapTargetSize.shrinkWrap,
                                  //     alignment: Alignment.centerLeft,
                                  //   ),
                                  //   onPressed: null,
                                  //   child: const Text(
                                  //     'Import cards',
                                  //     style: TextStyle(
                                  //       color: Color(0xFF133266),
                                  //       fontSize: 16,
                                  //       fontWeight: FontWeight.bold,
                                  //       decoration: TextDecoration.underline,
                                  //       decorationColor: Color(0xFF133266),
                                  //       decorationThickness: 2,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              )
                            : const SizedBox(
                                height: 0,
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
                    widget.deckId != null && widget.deckId.isNotEmpty
                        ? (!isEdited ? 'Go back' : 'Save changes')
                        : _cards.isEmpty && _deckName == ''
                            ? 'Go back'
                            : 'Save deck',
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
