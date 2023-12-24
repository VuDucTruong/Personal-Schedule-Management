import 'package:flutter/material.dart';

const String CONGVIEC = 'CONGVIEC';
const String CHUKY = 'CHUKY';
const String KHACHMOI = 'KHACHMOI';
const String LCV = 'LOAICONGVIEC';
const String NGUOIDUNG = 'NGUOIDUNG';
const String THONGBAO = 'THONGBAO';
const String THONGKE = 'THONGKE';
const String CONGVIECHT = 'CONGVIECHT';
const String BAN_ACCOUNT = 'BAN_ACCOUNT';
const String THUMOI = 'THUMOI';
const String SYNC = 'SYNC';
const List<String> REMINDER_LIST = [
  'Trước 15 phút',
  'Trước 30 phút',
  'Trước 1 giờ',
  'Trước 1 ngày',
  'Tùy chỉnh....'
];
const List<String> REMINDER_DAY_LIST = [
  'Vào ngày này lúc 9:00',
  'Trước 1 ngày lúc 9:00',
  'Trước 2 ngày lúc 9:00',
  'Trước 1 tuần lúc 9:00',
  'Tùy chỉnh....'
];
const Map<String, String> weekDaysMap = {
  'T2': 'MO',
  'T3': 'TU',
  'T4': 'WE',
  'T5': 'TH',
  'T6': 'FR',
  'T7': 'SA',
  'CN': 'SU'
};
// shared preferences
const String THEME = 'theme';
const String DARKMODE = 'darkmode';
const String DATE_FORMAT = 'date_format';

class AppDateFormat {
  static const DAY_MONTH_YEAR = 'dd/MM/yyyy';
  static const MONTH_DAY_YEAR = 'MM/dd/yyyy';
  static const YEAR_MONTH_DAY = 'yyyy/MM/dd';
  static const YEAR_DAY_MONTH = 'yyyy/dd/MM';
  static const TIME_24H = 'HH:mm';
  static const TIME_12H = 'hh:mm a';
}

const String TIME_24H_FORMAT = 'time_24';
const String WEATHER = 'weather';
const String RINGTONE = 'ringtone';
const String DEFAULT_RINGTONE = 'assets/ringtones/bird_sound.mp3';
const List<Color> COLOR_LEVEL = [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.lightGreenAccent,
  Colors.green
];
const Map<String, int> PRIORITY_MAP = {
  'Cao nhất': 1,
  'Cao': 2,
  'Trung bình': 3,
  'Thấp': 4,
  'Thấp nhất': 5
};
