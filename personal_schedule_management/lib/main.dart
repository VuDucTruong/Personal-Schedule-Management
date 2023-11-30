import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_schedule_management/core/data/datasource/remote/api_services.dart';
import 'package:personal_schedule_management/features/pages/calendar_page.dart';
import 'package:personal_schedule_management/features/pages/report_page.dart';
import 'package:personal_schedule_management/features/pages/settings_page.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

import 'config/theme/app_theme.dart';
import 'core/data/datasource/remote/firebase_options.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDependencies();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedIndex = 0;
  final pageList = [
    CalendarPage(),
    ReportPage(),
    SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    ApiServices apiServices = ApiServices();
    apiServices.fetchWeatherData();
    // TODO: implement build
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('vi'),
      ],
      locale: const Locale('vi'),
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
            bottomNavigationBar: SlidingClippedNavBar(
              barItems: [
                BarItem(title: 'Lịch', icon: FontAwesomeIcons.calendar),
                BarItem(
                    title: 'Thống kê',
                    icon: FontAwesomeIcons.magnifyingGlassChart),
                BarItem(title: 'Cài đặt', icon: FontAwesomeIcons.gear)
              ],
              iconSize: 20,
              selectedIndex: selectedIndex,
              onButtonPressed: (int index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              activeColor: lightColorScheme.primary,
            ),
            body: pageList[selectedIndex]),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
