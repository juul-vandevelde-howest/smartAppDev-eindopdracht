import 'package:flutter/material.dart';

Container studyCard(BuildContext context, String word) {
  return Container(
    width: double.infinity,
    height: MediaQuery.of(context).size.height * 0.65,
    decoration: BoxDecoration(
      color: Colors.white,
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
    child: Center(
      child: Text(
        word,
        style: const TextStyle(
          color: Color(0xFF133266),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
