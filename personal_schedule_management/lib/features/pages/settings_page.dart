import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_schedule_management/config/routes/routes.dart';
import 'package:personal_schedule_management/config/text_styles/app_text_style.dart';
import 'package:personal_schedule_management/config/theme/app_theme.dart';
import 'package:personal_schedule_management/features/controller/settings_controller.dart';
import 'package:personal_schedule_management/features/pages/forgotpass_page.dart';
import 'package:personal_schedule_management/features/pages/login_page.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SettingsController settingsController = SettingsController();

  Future<void> launchEmailApp(String email) async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );

    try {
      await launch(_emailLaunchUri.toString());
    } catch (e) {
      print('Không thể mở ứng dụng email: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    User? user = settingsController.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cài đặt',
          style: AppTextStyle.h2,
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                margin: EdgeInsets.only(bottom: 4),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage('assets/image/setting_image.jpg'),
                        fit: BoxFit.cover)),
              ),
              Builder(builder: (context) {
                if (user != null) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            child: Icon(FontAwesomeIcons.userLarge),
                            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: 'Xin chào',
                                style: TextStyle(color: Theme.of(context).colorScheme.onBackground)),
                            TextSpan(
                                text: ' ${user.displayName ?? user.email!}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.onBackground)),
                          ])),
                          Spacer(),
                          PopupMenuButton(
                            offset: Offset(0, 40),
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                    child: Text('Đăng xuất'),
                                    onTap: () async {
                                      await settingsController.signOut();
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginPage(),
                                          ));
                                    }),
                                PopupMenuItem(
                                  child: Text('Đổi mật khẩu'),
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ForgotPassPage(),
                                      )),
                                ),
                              ];
                            },
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ));
                    },
                    child: Card(
                      child: Row(
                        children: [
                          CircleAvatar(
                            child: Icon(FontAwesomeIcons.userLarge),
                            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                          ),
                          Text('Đăng nhập'),
                        ],
                      ),
                    ),
                  );
                }
              }),
              SizedBox(
                height: 12,
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(8),
                      child: Text(
                        'Lịch',
                        style: AppTextStyle.h2_5.copyWith(
                          color: Theme.of(context).colorScheme.onBackground
                        ),
                      ),
                    ),
                    SettingItem(
                      color: Colors.pinkAccent,
                      content: 'Lịch của bạn',
                      iconData: FontAwesomeIcons.solidCircleUser,
                      isSwitch: false,
                      function: null,
                    ),
                    SettingsDivider(),
                    SettingItem(
                      content: 'Đồng bộ hóa tài khoản',
                      iconData: Icons.cloud_sync,
                      color: Colors.tealAccent,
                      isSwitch: false,
                      function: () => AppRoutes.toSyncCalendarPage(context),
                    ),
                    SettingsDivider(),
                    SettingItem(
                      color: Colors.deepPurpleAccent,
                      content: 'Định dạng ngày',
                      iconData: FontAwesomeIcons.calendarDays,
                      isSwitch: false,
                      function: null,
                    ),
                    SettingsDivider(),
                    SettingItem(
                      color: Colors.red,
                      content: 'Định dạng thời gian 24h',
                      iconData: Icons.av_timer,
                      isSwitch: true,
                      function: null,
                    ),
                    SettingsDivider(),
                    SettingItem(
                      color: Colors.lightBlueAccent,
                      content: 'Hiển thị thời tiết',
                      iconData: FontAwesomeIcons.cloudSun,
                      isSwitch: true,
                      function: null,
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(8),
                      child: Text(
                        'Tùy chỉnh',
                        style: AppTextStyle.h2_5.copyWith(
                          color: Theme.of(context).colorScheme.onBackground
                        ),
                      ),
                    ),
                    SettingItem(
                      color: Colors.blue,
                      content: 'Tiện ích',
                      iconData: FontAwesomeIcons.mobile,
                      isSwitch: false,
                      function: null,
                    ),
                    SettingsDivider(),
                    SettingItem(
                      color: Colors.orangeAccent,
                      content: 'Nhạc chuông',
                      iconData: FontAwesomeIcons.music,
                      isSwitch: false,
                      function: null,
                    ),
                    SettingsDivider(),
                    SettingItem(
                      color: Colors.yellowAccent,
                      content: 'Thông báo & nhắc nhở',
                      iconData: FontAwesomeIcons.solidBell,
                      isSwitch: false,
                      function: null,
                    ),
                    SettingsDivider(),
                    SettingItem(
                      function: () => AppRoutes.toAppThemePage(context),
                      color: Colors.purpleAccent,
                      content: 'Giao diện',
                      iconData: FontAwesomeIcons.brush,
                      isSwitch: false,
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(8),
                      child: Text(
                        'Hỗ trợ',
                        style: AppTextStyle.h2_5.copyWith(
                            color: Theme.of(context).colorScheme.onBackground
                        ),
                      ),
                    ),
                    SettingItem(
                      color: Colors.lightGreenAccent,
                      content: 'Phản hồi',
                      iconData: FontAwesomeIcons.comments,
                      isSwitch: false,
                      // function: () {
                      //   launchEmailApp('personalschedulemanager@gmail.com');
                      // },
                      function: null,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 0.5,
      color: Colors.grey,
      thickness: 0.25,
    );
  }
}

class SettingItem extends StatelessWidget {
  String content;
  IconData iconData;
  Color color;
  bool isSwitch;
  VoidCallback? function;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: ListTile(
        title: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: color),
              child: Icon(iconData, color: Colors.white),
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              content,
              style: AppTextStyle.normal,
            ),
          ],
        ),
        trailing: isSwitch
            ? Switch(value: false, onChanged: (_) {})
            : Icon(FontAwesomeIcons.angleRight),
      ),
    );
  }

  SettingItem(
      {required this.function,
      required this.content,
      required this.iconData,
      required this.color,
      required this.isSwitch,
      super.key});
}
