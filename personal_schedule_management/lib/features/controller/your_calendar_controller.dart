import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:personal_schedule_management/core/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class YourCalendarController {
  final DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();
  bool isSync = true;
  List<Calendar> accountList = [];
  Map<String, bool> accountMap = {};
  Future<List<Calendar>> getAllGoogleAccounts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? result = prefs.getBool(SYNC);
    if (result != null) {
      isSync = result;
    } else {
      isSync = await Permission.calendarFullAccess.isGranted;
      prefs.setBool(SYNC, isSync);
    }
    if (await Permission.calendarFullAccess.isGranted) {
      accountList.clear();
      final calendarsResult = (await deviceCalendarPlugin.retrieveCalendars());
      final List<Calendar> calendars = calendarsResult.data as List<Calendar>;
      createCalendarWithoutDuplicated(calendars, accountList);
      await getAccountMap();
    }
    return accountList;
  }

  Future<void> getAccountMap() async {
    accountMap.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> banList = prefs.getStringList(BAN_ACCOUNT) ?? [];
    for (var element in accountList) {
      if (element.accountName != null && element.accountName!.isNotEmpty) {
        accountMap.addAll({
          element.accountName ?? '': (!banList.contains(element.accountName))
        });
      }
    }
  }

  void createCalendarWithoutDuplicated(
      List<Calendar> calendarList, List<Calendar> newList) {
    Set<String?> accountNameSet = Set();
    calendarList.forEach((element) {
      if (!accountNameSet.contains(element.accountName)) {
        accountNameSet.add(element.accountName);
        newList.add(element);
      }
    });
  }

  Future<bool> changeSync(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value) {
      if (await Permission.calendarFullAccess.isGranted) {
        isSync = value;
        prefs.setBool(SYNC, isSync);
        return true;
      } else {
        openAppSettings();
      }
    } else {
      isSync = value;
      prefs.setBool(SYNC, isSync);
      return true;
    }
    isSync = await Permission.calendarFullAccess.isGranted;
    prefs.setBool(SYNC, isSync);
    return true;
  }

  Future<void> addToBanList(String account) async {
    accountMap[account] = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> currentAccount = prefs.getStringList(BAN_ACCOUNT) ?? [];
    currentAccount.add(account);
    prefs.setStringList(BAN_ACCOUNT, currentAccount);
    print(currentAccount);
  }

  Future<void> removeToBanList(String account) async {
    accountMap[account] = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> currentAccount = prefs.getStringList(BAN_ACCOUNT) ?? [];
    currentAccount.remove(account);
    prefs.setStringList(BAN_ACCOUNT, currentAccount);
    print(currentAccount);
  }
}
