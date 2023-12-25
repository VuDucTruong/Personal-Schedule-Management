import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:personal_schedule_management/core/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class YourCalendarController {
  final DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();
  bool isSync = true;
  Map<String, List<Calendar>> accountMapList = {};
  List<MapEntry<String, List<Calendar>>> accountList = [];
  Map<String, bool> accountMap = {};
  Future<void> getAllGoogleAccounts() async {
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
      getAccountListFromCalendar(calendars);
      await getAccountMap();
    }
  }

  Future<void> getAccountMap() async {
    accountMap.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> banList = prefs.getStringList(BAN_ACCOUNT) ?? [];

    for (var element in accountList) {
      for (var i in element.value) {
        // print({element.key + '\n' + (i.name ?? '') : !banList.contains(i.id)});
        accountMap.addAll({element.key + '\n' + (i.name ?? ''): !banList.contains(i.id)});
      }
    }
  }

  void getAccountListFromCalendar(List<Calendar> calendarList) {
    accountMapList.clear();
    for (var element in calendarList) {
      if (accountMapList.containsKey(element.accountName)) {
        accountMapList[element.accountName]?.add(element);
      } else {
        accountMapList.addAll({
          element.accountName ?? '': [element]
        });
      }
    }
    accountList = accountMapList.entries.toList();
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

  Future<void> addToBanList(String? account) async {
    if (account == null) return;
    accountMap[account] = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> currentAccount = prefs.getStringList(BAN_ACCOUNT) ?? [];
    currentAccount.add(account);
    prefs.setStringList(BAN_ACCOUNT, currentAccount);
    print(currentAccount);
  }

  Future<void> removeToBanList(String? account) async {
    if (account == null) return;
    accountMap[account] = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> currentAccount = prefs.getStringList(BAN_ACCOUNT) ?? [];
    currentAccount.remove(account);
    prefs.setStringList(BAN_ACCOUNT, currentAccount);
    print(currentAccount);
  }
}
