const String CONGVIEC = 'CONGVIEC';
const String CHUKY = 'CHUKY';
const String KHACHMOI = 'KHACHMOI';
const String LCV = 'LOAICONGVIEC';
const String NGUOIDUNG = 'NGUOIDUNG';
const String THONGBAO = 'THONGBAO';
const String THONGKE = 'THONGKE';
const String CONGVIECHT = 'CONGVIECHT';
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
abstract class AppTheme {
  static const DEFAULT = 'Default';
  static const ELECTRIC_VIOLET = 'Electric Violet';
  static const HIPPIE_BLUE = 'Hippe Blue';
  static const GREEN_FOREST = 'Green Forest';
  static const SAKURA = 'Sakura';
  static const RED_WINE = 'Red wine';
  static const GOLD_SUNSET = 'Gold sunset';
  static const BLUE_DELIGHT = 'Blue Delight';
}

const String DATE_FORMAT = 'date_format';
abstract class AppDateFormat {
  static const DAY_MONTH_YEAR = 'dd/MM/yyyy';
  static const MONTH_DAY_YEAR = 'MM/dd/yyyy';
  static const YEAR_MONTH_DAY = 'yyyy/MM/dd';
  static const YEAR_DAY_MONTH = 'yyyy/dd/MM';
}

const String TIME_24H_FORMAT = 'time_24';
const String WEATHER = 'weather';

