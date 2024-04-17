import 'package:flutter/material.dart';

class Navigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const Navigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      iconSize: 30,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.folder),
          label: 'Study',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle),
          label: 'Add',
        ),
      ],
    );
  }
}
