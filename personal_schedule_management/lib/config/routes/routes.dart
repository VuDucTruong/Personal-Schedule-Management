import 'package:flutter/material.dart';
import 'package:personal_schedule_management/features/pages/work_category_page.dart';

class AppRoutes {
  static void toWorkCategoryPage(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkCategoryPage(),
      ));
}
