import 'dart:math';
import 'dart:typed_data';

import 'package:device_calendar/device_calendar.dart' as tz;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:personal_schedule_management/main.dart';
import 'package:recase/recase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'core/constants/constants.dart';

class NotificationServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings _androidFlutterLocalNotificationsPlugin =
      AndroidInitializationSettings('logo_icon');
  void initialNotification(BuildContext context) async {
    InitializationSettings initializationSettings = InitializationSettings(
        android: _androidFlutterLocalNotificationsPlugin);
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyApp(),
            ));
      },
    );
  }

  Future<void> createNotification(
      Appointment appointment, DateTime notificationTime, bool isAlarm) async {
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.getLocation('Asia/Ho_Chi_Minh'),
        notificationTime.year,
        notificationTime.month,
        notificationTime.day,
        notificationTime.hour,
        notificationTime.minute,
        0);
    print('This is Alarm : ${isAlarm}');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String musicPath = prefs.getString(RINGTONE) ?? DEFAULT_RINGTONE;
    List<String> musics = musicPath.split('/').last.split('.');
    AndroidNotificationDetails androidNotificationDetails =
        chooseNotificationChannel(musics.first, isAlarm);
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    /*await _flutterLocalNotificationsPlugin.show(
      0,
      '',
      '',
      notificationDetails,
    );*/
    print('Thông báo vào ${scheduledDate}');
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        Random().nextInt(999),
        appointment.subject,
        'Hãy hoàn thành công việc này nào!!',
        scheduledDate,
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exact);
  }

  Future<void> cancelNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  AndroidNotificationDetails chooseNotificationChannel(
      String musicPath, bool isAlarm) {
    const int insistentFlag = 4;
    return AndroidNotificationDetails(musicPath, musicPath,
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        additionalFlags:
            isAlarm ? Int32List.fromList(<int>[insistentFlag]) : null,
        sound: RawResourceAndroidNotificationSound(musicPath));
  }
}
