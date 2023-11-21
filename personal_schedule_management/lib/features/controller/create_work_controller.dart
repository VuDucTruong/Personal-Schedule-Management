import 'package:flutter/material.dart';

class CreateWorkController extends ChangeNotifier {
  int selectedColorRadio = 0;
  void onChangedColorRadio(int index) {
    selectedColorRadio = index;
    notifyListeners();
  }
}
