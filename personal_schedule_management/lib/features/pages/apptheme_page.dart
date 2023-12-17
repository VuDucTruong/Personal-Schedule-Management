import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_schedule_management/features/controller/settings_controller.dart';
import '../../config/theme/app_theme.dart';

class AppThemePage extends StatefulWidget {
  AppThemePage();

  @override
  _AppThemePageState createState() => _AppThemePageState();
}

class _AppThemePageState extends State<AppThemePage> {
  SettingsController settingsController = SettingsController();
  String? _currentTheme;
  bool _currentDarkMode = false;
  String _selectedTheme = AppTheme.DEFAULT;

  List<String> _AppThemeNameList =
  [
    AppTheme.DEFAULT,
    AppTheme.ELECTRIC_VIOLET,
    AppTheme.BLUE_DELIGHT,
    AppTheme.HIPPIE_BLUE,
    AppTheme.GREEN_FOREST,
    AppTheme.GOLD_SUNSET,
    AppTheme.SAKURA,
    AppTheme.RED_WINE
  ];

  Future<void> _GetData() async {
    print('AppTheme Build!');
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(
              child: CircularProgressIndicator()
          );
        }
    );
    _currentTheme = await settingsController.GetAppTheme();
    print('pass get theme!');
    _selectedTheme = _currentTheme ?? AppTheme.DEFAULT;
    _currentDarkMode = await settingsController.GetDarkMode() ?? false;
    print('pass get dark mode!');
    Navigator.of(context, rootNavigator: true).pop();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      this._GetData();
    });
  }

  @override
  void dispose() {
    _currentTheme = _selectedTheme;
    settingsController.SetAppTheme(_selectedTheme);
    _currentDarkMode = AppTheme.IsDarkMode;
    settingsController.SetDarkMode(_currentDarkMode);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const buttonRatio = 0.9;

    List<Container> AppThemeList = [];
    _AppThemeNameList.forEach((element) {

      AppThemeList.add(Container(
        alignment: Alignment.center,
        height: 56,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 4.0),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: _selectedTheme == element ?
                              Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.background,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    width: 4,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(50))),
          ),
          onPressed: () {
            /* do something */
            _selectedTheme = element;
            AppTheme.of(context, listen: false).LoadAppTheme(element);
          },
          child: Container(
            height: 42,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Icon(Icons.image,
                        size: 40,
                        color: _selectedTheme == element ?
                          settingsController.GetAppThemeExample(element).onPrimary :
                          settingsController.GetAppThemeExample(element).primary)
                ),

                Text(element,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: _selectedTheme == element ?
                            Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onBackground)
                ),
              ],
            ),
          ),
        )
      ));
    });

    return SafeArea(
      child: Builder(
        builder: (context) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: false,
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                icon: Icon(FontAwesomeIcons.circleChevronLeft,
                    size: 40, color: Theme.of(context).colorScheme.primary)),
            title: Text('Giao diện',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold)),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                InkWell(
                  child: ListTile(
                    title: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppTheme.of(context, listen: true).darkMode ? Colors.yellow : Colors.black),
                          child: Icon(Icons.dark_mode,
                                    color: Theme.of(context).colorScheme.background),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text('Chế độ tối',
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                            )
                        ),
                      ],
                    ),
                    trailing: Switch(value: AppTheme.of(context, listen: true).darkMode,
                                    onChanged: (isOn) {
                                      AppTheme.of(context, listen: false).ToggleDarkMode();
                                    }
                      )
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 4.0, top: 4.0, bottom: 4.0),
                  child: Text('Theme',
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.bold)
                  ),
                ),

                Column(
                  children: AppThemeList,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
