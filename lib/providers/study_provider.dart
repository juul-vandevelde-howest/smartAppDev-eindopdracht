import 'package:flutter/material.dart';

class StudyProvider with ChangeNotifier {
  bool _flipped = false;
  int _currentIndex = 1;
  int _totalCards = 0;
  int _learningCount = 0;
  int _knownCount = 0;
  String _deckId = '';

  bool get flipped => _flipped;
  int get currentIndex => _currentIndex;
  int get learningCount => _learningCount;
  int get knownCount => _knownCount;
  int get totalCards => _totalCards;
  String get deckId => _deckId;

  void flip() {
    _flipped = true;
    notifyListeners();
  }

  void setDeckId(String deckId) {
    _deckId = deckId;
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

  void setTotalCards(int totalCards) {
    _totalCards = totalCards;
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
