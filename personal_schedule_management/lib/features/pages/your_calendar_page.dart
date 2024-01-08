import 'dart:async';
import 'dart:math';

import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_schedule_management/features/controller/calendar_controller.dart';
import 'package:personal_schedule_management/features/controller/settings_controller.dart';
import 'package:personal_schedule_management/features/controller/your_calendar_controller.dart';
import '../../config/text_styles/app_text_style.dart';
import '../../config/theme/app_theme.dart';

class YourCalendarPage extends StatefulWidget {
  YourCalendarPage();

  @override
  _YourCalendarPageState createState() => _YourCalendarPageState();
}

class _YourCalendarPageState extends State<YourCalendarPage> {
  // Toggle for "link Google accounts options"
  YourCalendarController yourCalendarController = YourCalendarController();
  bool _modified = false;

  Future<void> _close(BuildContext context) async {
    if (_modified) {
      CalendarPageController.isSyncCalendarModified = true;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      yourCalendarController.getAllGoogleAccounts().whenComplete(() {
        if (mounted) {
          setState(() {});
        }
      });
    });
    return SafeArea(
      child: Builder(builder: (context) {
        return PopScope(
            onPopInvoked: (bool didPoop) async {
              if (didPoop) {
                await _close(context);
              }
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                centerTitle: false,
                leading: IconButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back,
                        size: 40,
                        color: Theme.of(context).colorScheme.primary)),
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
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 4.0,
                                    top: 4.0,
                                    right: 4.0,
                                    bottom: 4.0),
                                child: InkWell(
                                    child: ListTile(
                                  title: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            5.0), //or 15.0
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          color: Colors.white,
                                          child: Image.asset(
                                              'assets/image/google_image.png'),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Text('Tài khoản Google',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimaryContainer,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  trailing: Switch(
                                    value: yourCalendarController.isSync,
                                    onChanged: (value) async {
                                      if (await yourCalendarController
                                          .changeSync(value)) {
                                        _modified = true;
                                        setState(() {});
                                      }
                                    },
                                  ),
                                ))),
                            Visibility(
                              visible: yourCalendarController.isSync,
                              child: ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount:
                                    yourCalendarController.accountList.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      yourCalendarController
                                          .accountList[index].key,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    subtitle: Column(
                                      children: [
                                        ...yourCalendarController
                                            .accountList[index].value
                                            .map((e) => CheckboxListTile(
                                                  value: yourCalendarController
                                                          .accountMap[
                                                      yourCalendarController
                                                              .accountList[
                                                                  index]
                                                              .key +
                                                          '\n' +
                                                          (e.name ?? '')],
                                                  onChanged: (value) {
                                                    if (value != null) {
                                                      if (!value) {
                                                        yourCalendarController
                                                            .addToBanList(e.id);
                                                      } else {
                                                        yourCalendarController
                                                            .removeToBanList(
                                                                e.id);
                                                      }
                                                      try {
                                                        yourCalendarController
                                                                .accountMap[
                                                            yourCalendarController
                                                                    .accountList[
                                                                        index]
                                                                    .key +
                                                                '\n' +
                                                                (e.name ??
                                                                    '')] = value;
                                                      } catch (e) {
                                                        print(e);
                                                      }
                                                      _modified = true;
                                                      setState(() {});
                                                    }
                                                  },
                                                  title: Text(e.name ?? ''),
                                                ))
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ));
      }),
    );
  }
}
