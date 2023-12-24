import 'package:flutter/material.dart';
import 'package:personal_schedule_management/core/constants/constants.dart';
import 'package:personal_schedule_management/core/data/repository/user_respository.dart';
import 'package:personal_schedule_management/core/domain/repository_impl/user_respository_impl.dart';
import 'package:personal_schedule_management/features/pages/calendar%20pages/work_detail_page.dart';
import 'package:personal_schedule_management/features/widgets/stateful/create_email_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddGuestEmailController {
  AddGuestEmailController(this.emailList);
  List<String> emailList = [];
  List<String> userEmailsList = [];

  Future<void> openAddEmailDialog(
      BuildContext context, VoidCallback setStateCallBack) async {
    showDialog(
      context: context,
      builder: (context) => AddEmailDialog(this, setStateCallBack),
    );
  }

  Future<bool> isExistInUsersList(String email) async {
    userEmailsList = await UserRespositoryImpl().getAllUserEmail();
    if (userEmailsList.contains(email)) {
      return true;
    }
    return false;
  }

  Future<bool> addEmail(String email) async {
    bool isExistUser = await isExistInUsersList(email);
    if (emailList.contains(email)) return false;
    try {
      emailList.add(email);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  void removeEmail(int index) {
    try {
      emailList.removeAt(index);
    } catch (e) {
      print(e);
    }
  }
}
