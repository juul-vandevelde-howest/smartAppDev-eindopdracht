import 'package:flip/providers/study_provider.dart';
import 'package:flip/widgets/study_card.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';

class FlipCard extends StatefulWidget {
  final String front;
  final String back;

  const FlipCard({super.key, required this.front, required this.back});

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
      onDismissed: (direction) {
        studyProvider.nextCard();
        if (direction == DismissDirection.endToStart) {
          studyProvider.updateLearningCount();
        } else {
          studyProvider.updateKnownCount();
          // TODO: update in database
        }
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
