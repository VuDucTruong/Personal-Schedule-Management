import 'package:firebase_auth/firebase_auth.dart';
import 'package:personal_schedule_management/config/theme/app_theme.dart';
import 'package:personal_schedule_management/core/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController {
  User? get currentUser => FirebaseAuth.instance.currentUser;

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> SetTime24hFormatSetting(bool result) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(TIME_24H_FORMAT, result);
  }

  Future<bool?> GetTime24hFormatSetting() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(TIME_24H_FORMAT);
  }

  Future<void> SetWeatherSetting(bool result) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(WEATHER, result);
  }

  Future<bool?> GetWeatherSetting() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(WEATHER);
  }

  Future<void> SetDateFormat(format) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(DATE_FORMAT, format);
  }

  Future<String?> GetDateFormat() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(DATE_FORMAT);
  }

  Future<void> SetAppTheme(format) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(THEME, format);
  }

  Future<String?> GetAppTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(THEME);
  }

  void LoadAppTheme(AppThemeName) {
    switch (AppThemeName)
    {
      case AppTheme.DEFAULT:
        AppThemeSet_Default();
        break;
      case AppTheme.ELECTRIC_VIOLET:
        AppThemeSet_ElectricViolet();
        break;
      case AppTheme.BLUE_DELIGHT:
        AppThemeSet_BlueDelight();
        break;
      case AppTheme.HIPPIE_BLUE:
        AppThemeSet_HippieBlue();
        break;
      case AppTheme.GOLD_SUNSET:
        AppThemeSet_GoldSunset();
        break;
      case AppTheme.GREEN_FOREST:
        AppThemeSet_GreenForest();
        break;
      case AppTheme.RED_WINE:
        AppThemeSet_RedWine();
        break;
      case AppTheme.SAKURA:
        AppThemeSet_Sakura();
        break;
      default:
        AppThemeSet_Default();
    }
  }
}
