import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_schedule_management/config/routes/routes.dart';
import 'package:personal_schedule_management/config/text_styles/app_text_style.dart';
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
  bool isFormatTime24h = false;
  bool isShowWeather = false;
  bool hasCalledGetData = false;
  String selectedDateFormat = '';

  Future<void> updateDateFormat(String newDateFormat) async {
    SettingsController settingsController = SettingsController();
    await settingsController.SetDateFormat(newDateFormat);
    selectedDateFormat = newDateFormat;
  }

  void showDateFormatDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Chọn định dạng ngày:'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('dd/MM/yyyy'),
                trailing: selectedDateFormat == 'dd/MM/yyyy'
                    ? Icon(Icons.check)
                    : null,
                onTap: () {
                  updateDateFormat('dd/MM/yyyy');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('MM/dd/yyyy'),
                trailing: selectedDateFormat == 'MM/dd/yyyy'
                    ? Icon(Icons.check)
                    : null,
                onTap: () {
                  updateDateFormat('MM/dd/yyyy');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('yyyy/MM/dd'),
                trailing: selectedDateFormat == 'yyyy/MM/dd'
                    ? Icon(Icons.check)
                    : null,
                onTap: () {
                  updateDateFormat('yyyy/MM/dd');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('yyyy/dd/MM'),
                trailing: selectedDateFormat == 'yyyy/dd/MM'
                    ? Icon(Icons.check)
                    : null,
                onTap: () {
                  updateDateFormat('yyyy/dd/MM');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> getData() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    isFormatTime24h =
        await settingsController.GetTime24hFormatSetting() ?? false;
    isShowWeather = await settingsController.GetWeatherSetting() ?? true;
    Navigator.of(context).pop();
    setState(() {
      isShowWeather = isShowWeather;
    });
    hasCalledGetData = true;
  }

  Future<void> launchEmailApp(String email) async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'Góp_Ý_Của_Người_Dùng',
      },
    );

    try {
      await launchUrl(_emailLaunchUri);
    } catch (e) {
      print('Không thể mở ứng dụng email: $e');
    }
  }

  Future<void> formatTime24h() async {
    setState(() {
      isFormatTime24h = !isFormatTime24h;
    });
    await settingsController.SetTime24hFormatSetting(isFormatTime24h);
  }

  Future<void> showWeather() async {
    setState(() {
      isShowWeather = !isShowWeather;
    });
    await settingsController.SetWeatherSetting(isShowWeather);
  }

  @override
  Widget build(BuildContext context) {
    User? user = settingsController.currentUser;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Cài đặt',
            style: AppTextStyle.h2.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 200,
                  margin: const EdgeInsets.only(bottom: 4),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                          image: AssetImage('assets/image/setting_image.jpg'),
                          fit: BoxFit.cover)),
                ),
                Builder(builder: (context) {
                  if (!hasCalledGetData) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      getData(); // Gọi hàm getData sau khi frame đã hoàn thành
                    });
                  }
                  if (user != null) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: Icon(FontAwesomeIcons.userLarge),
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: 'Xin chào',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground)),
                              TextSpan(
                                  text: ' ${user.displayName ?? user.email!}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground)),
                            ])),
                            const Spacer(),
                            PopupMenuButton(
                              offset: const Offset(0, 40),
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                      child: const Text('Đăng xuất'),
                                      onTap: () async {
                                        await settingsController.signOut();
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage(),
                                            ));
                                      }),
                                  PopupMenuItem(
                                    child: const Text('Đổi mật khẩu'),
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ForgotPassPage(),
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
                              builder: (context) => const LoginPage(),
                            ));
                      },
                      child: Card(
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              child: const Icon(FontAwesomeIcons.userLarge),
                            ),
                            const Text('Đăng nhập'),
                          ],
                        ),
                      ),
                    );
                  }
                }),
                const SizedBox(
                  height: 12,
                ),
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: Text(
                          'Lịch',
                          style: AppTextStyle.h2_5.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer),
                        ),
                      ),
                      SettingItem(
                        color: Colors.pinkAccent,
                        content: 'Lịch của bạn',
                        iconData: FontAwesomeIcons.solidCircleUser,
                        isSwitch: false,
                        function: () => AppRoutes.toYourCalendarPage(context),
                      ),
                      const SettingsDivider(),
                      SettingItem(
                        content: 'Đồng bộ hóa tài khoản',
                        iconData: Icons.cloud_sync,
                        color: Colors.tealAccent,
                        isSwitch: false,
                        function: () => AppRoutes.toSyncCalendarPage(context),
                      ),
                      const SettingsDivider(),
                      SettingItem(
                        color: Colors.deepPurpleAccent,
                        content: 'Định dạng ngày',
                        iconData: FontAwesomeIcons.calendarDays,
                        isSwitch: false,
                        function: showDateFormatDialog,
                      ),
                      const SettingsDivider(),
                      SettingItem(
                        color: Colors.red,
                        content: 'Định dạng thời gian 24h',
                        iconData: Icons.av_timer,
                        isSwitch: true,
                        switchValue: isFormatTime24h,
                        function: formatTime24h,
                      ),
                      const SettingsDivider(),
                      SettingItem(
                        color: Colors.lightBlueAccent,
                        content: 'Hiển thị thời tiết',
                        iconData: FontAwesomeIcons.cloudSun,
                        isSwitch: true,
                        switchValue: isShowWeather,
                        function: showWeather,
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: Text(
                          'Tùy chỉnh',
                          style: AppTextStyle.h2_5.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer),
                        ),
                      ),
                      SettingItem(
                        color: Colors.blue,
                        content: 'Tiện ích',
                        iconData: FontAwesomeIcons.mobile,
                        isSwitch: false,
                        function: null,
                      ),
                      const SettingsDivider(),
                      SettingItem(
                        color: Colors.orangeAccent,
                        content: 'Nhạc chuông',
                        iconData: FontAwesomeIcons.music,
                        isSwitch: false,
                        function: () => AppRoutes.toRingtonePage(context),
                      ),
                      const SettingsDivider(),
                      SettingItem(
                        color: Colors.yellowAccent,
                        content: 'Thông báo & nhắc nhở',
                        iconData: FontAwesomeIcons.solidBell,
                        isSwitch: false,
                        function: null,
                      ),
                      const SettingsDivider(),
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
                        margin: const EdgeInsets.all(8),
                        child: Text(
                          'Hỗ trợ',
                          style: AppTextStyle.h2_5.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer),
                        ),
                      ),
                      SettingItem(
                        color: Colors.lightGreenAccent,
                        content: 'Phản hồi',
                        iconData: FontAwesomeIcons.comments,
                        isSwitch: false,
                        function: () {
                          launchEmailApp('personalschedulemanager@gmail.com');
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 0.5,
      color: Colors.grey,
      thickness: 0.25,
    );
  }
}

// ignore: must_be_immutable
class SettingItem extends StatefulWidget {
  SettingItem(
      {required this.function,
      required this.content,
      required this.iconData,
      required this.color,
      required this.isSwitch,
      this.switchValue = false,
      super.key});

  String content;
  IconData iconData;
  Color color;
  bool isSwitch;
  bool switchValue;
  VoidCallback? function;

  @override
  State<StatefulWidget> createState() => _SettingItem(
      function: function,
      content: content,
      iconData: iconData,
      color: color,
      isSwitch: isSwitch,
      switchValue: switchValue);
}

class _SettingItem extends State<SettingItem> {
  String content;
  IconData iconData;
  Color color;
  bool isSwitch;
  bool switchValue;
  VoidCallback? function;

  @override
  void didUpdateWidget(covariant SettingItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.switchValue != oldWidget.switchValue) {
      setState(() {
        switchValue = widget.switchValue;
      });
    }
  }

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
            const SizedBox(
              width: 16,
            ),
            Text(
              content,
              style: AppTextStyle.normal,
            ),
          ],
        ),
        trailing: isSwitch
            ? Switch(
                value: switchValue,
                onChanged: (value) {
                  if (function != null) {
                    function!();
                  }
                })
            : const Icon(FontAwesomeIcons.angleRight),
      ),
    );
  }

  _SettingItem(
      {required this.function,
      required this.content,
      required this.iconData,
      required this.color,
      required this.isSwitch,
      required this.switchValue});
}
