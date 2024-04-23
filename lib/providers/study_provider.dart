import 'package:flutter/material.dart';

class StudyProvider with ChangeNotifier {
  bool _flipped = false;
  int _currentIndex = 1;
  int _learningCount = 0;
  int _knownCount = 0;

  bool get flipped => _flipped;
  int get currentIndex => _currentIndex;
  int get learningCount => _learningCount;
  int get knownCount => _knownCount;

  void flip() {
    _flipped = true;
    notifyListeners();
  }

  void nextCard() {
    _currentIndex++;
    notifyListeners();
  }

  void updateLearningCount() {
    _learningCount++;
    notifyListeners();
  }

  void updateKnownCount() {
    _knownCount++;
    notifyListeners();
  }

  void reset() {
    _flipped = false;
    _currentIndex = 1;
    _learningCount = 0;
    _knownCount = 0;
    notifyListeners();
  }
}
