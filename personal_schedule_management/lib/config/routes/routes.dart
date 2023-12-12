import 'package:flutter/material.dart';
import 'package:personal_schedule_management/features/pages/apptheme_page.dart';
import 'package:personal_schedule_management/features/pages/chooseringtones_page.dart';
import 'package:personal_schedule_management/features/pages/sync_calendar_page.dart';
import 'package:personal_schedule_management/features/pages/work_category_page.dart';
import 'package:personal_schedule_management/features/pages/your_calendar_page.dart';

class AppRoutes {
  static void toWorkCategoryPage(BuildContext context, String category) =>
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WorkCategoryPage(category),
          ));
  static void toSyncCalendarPage(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SyncCalendarPage(),
      ));
  static void toAppThemePage(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppThemePage(),
      ));
  static void toRingtonePage(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RingtonesPage(),
      ));
  static void toYourCalendarPage(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => YourCalendarPage(),
      ));
}
