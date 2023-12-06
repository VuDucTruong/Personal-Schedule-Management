import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_schedule_management/features/controller/settings_controller.dart';
import '../../config/text_styles/app_text_style.dart';
import '../../config/theme/app_theme.dart';

class YourCalendarPage extends StatefulWidget {
  YourCalendarPage();

  @override
  _YourCalendarPageState createState() => _YourCalendarPageState();
}

class _YourCalendarPageState extends State<YourCalendarPage> {
  // Toggle for "link Google accounts options"
  bool _GoogleToggle = false;

  // TODO: Delete this after implementing Google accounts Getter
  static const List<String> _ExampleGoogleAccounts = [
    'example1@gmail.com',
    'example2@gmail.com',
  ];

  // TODO: Add user Google accounts to list
  List<String> _GoogleAccounts = _ExampleGoogleAccounts;
  Map<String, bool> _GoogleAccountToggles = {};

  void ToggleGoogleAccount(String accountName){
    bool oldValue = _GoogleAccountToggles[accountName] ?? false;
    _GoogleAccountToggles[accountName] = !oldValue;
    print(_GoogleAccountToggles);
  }

  Future<void> GetData() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(
              child: CircularProgressIndicator()
          );
        }
    );

    // TODO: Implement Google Accounts Getter here
    //============================================
    // Do something

    // Load user settings
    _GoogleToggle = true; // change this value later
    _GoogleAccounts.forEach((element) {
      _GoogleAccountToggles[element] = true; // change this value later
    });
    //============================================
    print(_GoogleAccountToggles);
    Navigator.of(context).pop();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      this.GetData();
    });
  }

  @override
  Widget build(BuildContext context) {
    const buttonRatio = 0.9;

    List<InkWell> GoogleAccountList = [];

    _GoogleAccounts.forEach((element) {
      GoogleAccountList.add(
          InkWell(
            child: ListTile(
              title: Row(
                children: [
                  Text(
                    element,
                    style: AppTextStyle.normal,
                  ),
                ],
              ),
              trailing: Switch(
                  value: _GoogleAccountToggles[element] ?? false,
                  onChanged: (value) {
                    ToggleGoogleAccount(element);
                    setState(() {});
                  }),
            )
          )
      );
    });

    return SafeArea(
      child: Builder(
        builder: (context) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: false,
            leading: IconButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                icon: Icon(FontAwesomeIcons.circleChevronLeft,
                    size: 40, color: Theme.of(context).colorScheme.primary)),
            title: Text('Lịch của bạn',
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
                Card(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 4.0, top: 4.0, right: 4.0, bottom: 4.0),
                        child: InkWell(
                          child: ListTile(
                            title: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),//or 15.0
                                  child: Container(
                                    height: 60.0,
                                    width: 60.0,
                                    color: Colors.white,
                                    child: Image.asset('assets/image/google_image.png'),
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Text('Tài khoản Google',
                                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                                        fontWeight: FontWeight.bold)
                                ),
                              ],
                            ),
                            trailing: Switch(
                                value: _GoogleToggle,
                                onChanged: (value) {
                                  _GoogleToggle = value;
                                  setState(() {});
                                })
                          )
                        )
                      ),

                      Container(
                        margin: const EdgeInsets.only(left: 16.0, right: 8.0, bottom: 4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _GoogleToggle ?
                          (GoogleAccountList.isEmpty ?
                          [Text('Không có tài khoản nào', style: AppTextStyle.normal)]
                              : GoogleAccountList)
                              : [],
                        ),
                      )
                    ],
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}