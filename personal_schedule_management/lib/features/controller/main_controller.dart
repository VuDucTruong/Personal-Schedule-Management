import 'package:flutter/material.dart';

class MainController extends ChangeNotifier {
  int selectedIndex = 0;
  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
