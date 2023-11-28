import 'package:flutter/material.dart';
import 'package:personal_schedule_management/features/widgets/stateful/create_work_category_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkCategoryController {
  List<String> workCategoryList = [];

  Future<List<String>> getWorkCategoryList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      workCategoryList = prefs.getStringList('LOAI_CV')!;
    } catch (e) {
      print(e);
    }
    return workCategoryList;
  }

  Future<void> openCreateWorkCategoryDialog(
      BuildContext context, VoidCallback setStateCallStack) async {
    showDialog(
      context: context,
      builder: (context) => WorkCategoryDialog(this, setStateCallStack),
    );
  }

  Future<bool> insertWorkCategory(String category) async {
    if (workCategoryList.contains(category)) return false;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      workCategoryList.add(category);
      prefs.setStringList('LOAI_CV', workCategoryList);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<void> removeWorkCategory(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      workCategoryList.removeAt(index);
      prefs.setStringList('LOAI_CV', workCategoryList);
    } catch (e) {
      print(e);
    }
  }
}
