import 'package:flip/routes/flip/add.dart';
import 'package:flip/routes/flip/settings.dart';
import 'package:flip/routes/flip/study.dart';
import 'package:flip/widgets/Navigation.dart';
import 'package:flutter/material.dart';

class FlipNavigation extends StatefulWidget {
  const FlipNavigation({super.key});

  @override
  FlipNavigationState createState() => FlipNavigationState();
}

class FlipNavigationState extends State<FlipNavigation> {
  int _currentIndex = 1;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const [
          Settings(),
          Study(),
          Add(),
        ],
      ),
      bottomNavigationBar: _currentIndex != 2
          ? Navigation(
              currentIndex: _currentIndex,
              onTap: (index) {
                _pageController.jumpToPage(
                  index,
                );
              },
            )
          : null,
    );
  }
}
