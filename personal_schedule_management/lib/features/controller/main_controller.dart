import 'package:flutter/material.dart';

class MainController extends ChangeNotifier {
  int selectedIndex = 1;
  String hello = 'Haha';
  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
