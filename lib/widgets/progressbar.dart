import 'package:flutter/material.dart';

class Progressbar extends StatelessWidget {
  final double value;

  const Progressbar({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
          value: value,
          minHeight: 4,
          color: Colors.white,
          backgroundColor: const Color(0xFF133266),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
