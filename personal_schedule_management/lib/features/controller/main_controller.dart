import 'package:flutter/material.dart';

class MainController extends ChangeNotifier {
  int selectedIndex = 0;
  String hello = 'Haha';
  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
