import 'package:flip/providers/study_provider.dart';
import 'package:flip/routes/flip/results.dart';
import 'package:flip/widgets/study_card.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class FlipCard extends StatefulWidget {
  final String front;
  final String back;
  final String deckId;

  const FlipCard(
      {super.key,
      required this.front,
      required this.back,
      required this.deckId});

  @override
  FlipCardState createState() => FlipCardState();
}

class FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    var studyProvider = Provider.of<StudyProvider>(context);

    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) async {
        if (direction == DismissDirection.endToStart) {
          studyProvider.updateLearningCount();
        } else {
          studyProvider.updateKnownCount();
          var url = Uri.parse(
              'http://10.0.2.2:3000/decks/${widget.deckId}/study?term=${widget.front}');
          await http.put(url);
        }
        studyProvider.totalCards == studyProvider.currentIndex
            ? Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (BuildContext context,
                      Animation<double> animation1,
                      Animation<double> animation2) {
                    return const Results();
                  },
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              )
            : studyProvider.nextCard();
      },
      child: GestureDetector(
        onTap: () {
          studyProvider.flip();
          if (_controller.isDismissed) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, child) {
            return Container(
              color: Colors.white,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0)
                  ..rotateY(pi * _controller.value),
                child: _controller.value < 0.5
                    ? studyCard(context, widget.front)
                    : Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..rotateY(pi),
                        child: studyCard(context, widget.back),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
