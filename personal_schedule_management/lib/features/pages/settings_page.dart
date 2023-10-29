import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_schedule_management/config/text_styles/app_text_style.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage('assets/image/setting_image.jpg'),
                        fit: BoxFit.cover)),
              ),
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
                        style: AppTextStyle.h2_5,
                      ),
                    ),
                    SettingItem(
                      color: Colors.pinkAccent,
                      content: 'Lịch của bạn',
                      iconData: FontAwesomeIcons.solidCircleUser,
                      isSwitch: false,
                    ),
                    SettingsDivider(),
                    SettingItem(
                      color: Colors.deepPurpleAccent,
                      content: 'Định dạng ngày',
                      iconData: FontAwesomeIcons.calendarDays,
                      isSwitch: false,
                    ),
                    SettingsDivider(),
                    SettingItem(
                      color: Colors.red,
                      content: 'Định dạng thời gian 24h',
                      iconData: FontAwesomeIcons.solidCircleUser,
                      isSwitch: true,
                    ),
                    SettingsDivider(),
                    SettingItem(
                      color: Colors.lightBlueAccent,
                      content: 'Hiển thị thời tiết',
                      iconData: FontAwesomeIcons.cloudSun,
                      isSwitch: true,
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
                        style: AppTextStyle.h2_5,
                      ),
                    ),
                    SettingItem(
                      color: Colors.blue,
                      content: 'Tiện ích',
                      iconData: FontAwesomeIcons.mobile,
                      isSwitch: false,
                    ),
                    SettingsDivider(),
                    SettingItem(
                      color: Colors.orangeAccent,
                      content: 'Nhạc chuông',
                      iconData: FontAwesomeIcons.music,
                      isSwitch: false,
                    ),
                    SettingsDivider(),
                    SettingItem(
                      color: Colors.yellowAccent,
                      content: 'Thông báo & nhắc nhở',
                      iconData: FontAwesomeIcons.solidBell,
                      isSwitch: false,
                    ),
                    SettingsDivider(),
                    SettingItem(
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
                        style: AppTextStyle.h2_5,
                      ),
                    ),
                    SettingItem(
                      color: Colors.lightGreenAccent,
                      content: 'Phản hồi',
                      iconData: FontAwesomeIcons.comments,
                      isSwitch: false,
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
  @override
  Widget build(BuildContext context) {
    return ListTile(
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
    );
  }

  SettingItem(
      {required this.content,
      required this.iconData,
      required this.color,
      required this.isSwitch,
      super.key});
}
