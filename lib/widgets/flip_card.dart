import 'package:flip/widgets/study_card.dart';
import 'package:flutter/material.dart';
import 'dart:math';

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
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          print("---------------------card still learning---------------------");
        } else {
          print("---------------------card learned---------------------");
        }
      },
      child: GestureDetector(
        onTap: () {
          if (_controller.isDismissed) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, child) {
            return Transform(
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
