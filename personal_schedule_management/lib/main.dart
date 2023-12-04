import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_schedule_management/core/data/datasource/remote/api_services.dart';
import 'package:personal_schedule_management/features/pages/calendar_page.dart';
import 'package:personal_schedule_management/features/pages/login_page.dart';
import 'package:personal_schedule_management/features/pages/report_page.dart';
import 'package:personal_schedule_management/features/pages/settings_page.dart';
import 'package:provider/provider.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'config/theme/app_theme.dart';
import 'core/data/datasource/remote/firebase_options.dart';
import 'injection_container.dart';
import 'notification_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDependencies();
  tz.initializeTimeZones();
  runApp(ChangeNotifierProvider(
    create: (_) => AppTheme(),
    child: MyApp(),
  ));
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
    GetIt.instance<NotificationServices>().initialNotification(context);
    ApiServices apiServices = ApiServices();
    apiServices.fetchWeatherData();
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
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
        theme: AppTheme.of(context, listen: true).lightTheme,
        darkTheme: AppTheme.of(context, listen: true).darkTheme,
        themeMode: AppTheme.of(context, listen: true).darkMode
            ? ThemeMode.dark
            : ThemeMode.light,
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
                activeColor: AppTheme.lightColorScheme.primary,
              ),
              body: pageList[selectedIndex]),
        ),
        debugShowCheckedModeBanner: false,
      );
    } else
      return LoginPage();
    // TODO: implement build
  }
}
