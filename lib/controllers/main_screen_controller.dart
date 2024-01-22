import 'package:flutter/material.dart';

class MainScreenNotifier extends ChangeNotifier {
  int _pageIndex = 0;
  int get pageIndex => _pageIndex;
  //setter method for assign the page index
  set pageIndex(int newIndex) {
    _pageIndex = newIndex;
    notifyListeners();
  }
}
