import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  Future<void> SetDateFormat(String format) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(DATE_FORMAT, format);
  }

  Future<String?> GetDateFormat() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(DATE_FORMAT);
  }

  Future<void> SetAppTheme(String format) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(THEME, format);
  }

  Future<String?> GetAppTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(THEME);
  }

  Future<void> SetDarkMode(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(DARKMODE, value);
  }

  Future<bool?> GetDarkMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(DARKMODE);
  }

  ColorScheme GetAppThemeExample(AppThemeName) {
    switch (AppThemeName) {
      case AppTheme.DEFAULT:
        return !AppTheme.IsDarkMode ? SchemeLight_default : SchemeDark_default;
      case AppTheme.ELECTRIC_VIOLET:
        return !AppTheme.IsDarkMode
            ? SchemeLight_ElectricViolet
            : SchemeDark_ElectricViolet;
      case AppTheme.BLUE_DELIGHT:
        return !AppTheme.IsDarkMode
            ? SchemeLight_BlueDelight
            : SchemeDark_BlueDelight;
      case AppTheme.HIPPIE_BLUE:
        return !AppTheme.IsDarkMode
            ? SchemeLight_HippieBlue
            : SchemeDark_HippieBlue;
      case AppTheme.GOLD_SUNSET:
        return !AppTheme.IsDarkMode
            ? SchemeLight_GoldSunset
            : SchemeDark_GoldSunset;
      case AppTheme.GREEN_FOREST:
        return !AppTheme.IsDarkMode
            ? SchemeLight_GreenForest
            : SchemeDark_GreenForest;
      case AppTheme.RED_WINE:
        return !AppTheme.IsDarkMode ? SchemeLight_RedWine : SchemeDark_RedWine;
      case AppTheme.SAKURA:
        return !AppTheme.IsDarkMode ? SchemeLight_Sakura : SchemeDark_Sakura;
      default:
        return !AppTheme.IsDarkMode ? SchemeLight_default : SchemeDark_default;
    }
  }

  Future<void> SetRingtone(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(RINGTONE, value);
  }

  Future<String?> GetRingtone() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(RINGTONE);
  }
}
