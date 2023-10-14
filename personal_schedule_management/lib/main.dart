import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_schedule_management/features/controller/main_controller.dart';
import 'package:personal_schedule_management/features/pages/calendar_page.dart';
import 'package:personal_schedule_management/features/pages/managemet_page.dart';
import 'package:personal_schedule_management/features/pages/settings_page.dart';
import 'package:provider/provider.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

import 'config/theme/app_theme.dart';
import 'features/pages/user_page.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => MainController())],
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    // TODO: implement build
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          textTheme: GoogleFonts.robotoTextTheme()),
      darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          textTheme: GoogleFonts.robotoTextTheme()),
      home: SafeArea(
        child: Scaffold(
          bottomNavigationBar: Consumer<MainController>(
            builder: (context, controller, child) => SlidingClippedNavBar(
              barItems: [
                BarItem(title: 'Lịch', icon: FontAwesomeIcons.calendar),
                BarItem(title: 'Quản lý', icon: FontAwesomeIcons.listCheck),
                BarItem(title: 'Cá nhân', icon: FontAwesomeIcons.user),
                BarItem(title: 'Cài đặt', icon: FontAwesomeIcons.gear)
              ],
              iconSize: 20,
              selectedIndex: controller.selectedIndex,
              onButtonPressed: (int index) {
                controller.changeIndex(index);
                pageController.animateToPage(index,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeIn);
              },
              activeColor: lightColorScheme.primary,
            ),
          ),
          body: PageView(
            controller: pageController,
            children: [
              CalendarPage(),
              ManagementPage(),
              UserPage(),
              SettingsPage()
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
