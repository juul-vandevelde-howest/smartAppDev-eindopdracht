import 'package:flutter/material.dart';

class AddCard extends StatelessWidget {
  final String term;
  final String definition;
  final int index;
  final int total;
  final Function(String, String, int) updateFunction;

  const AddCard({
    super.key,
    this.term = "",
    this.definition = "",
    this.index = -1,
    this.total = -1,
    required this.updateFunction(String term, String definition, int index),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        updateFunction(
                            value, definition, index != -1 ? index - 1 : total);
                      },
                      initialValue: term,
                      cursorColor: const Color(0xFF133266),
                      cursorWidth: 3,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF133266),
                            width: 3,
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                        hintText: "Type term here",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        updateFunction(
                            term, value, index != -1 ? index - 1 : total);
                      },
                      initialValue: definition,
                      cursorColor: const Color(0xFF133266),
                      cursorWidth: 3,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF133266),
                            width: 3,
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                        hintText: "Type definition here",
                        hintStyle: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    if (index != -1) const SizedBox(height: 10),
                    if (index != -1)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Card $index of $total",
                            style: const TextStyle(
                              color: Color(0xFF133266),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
