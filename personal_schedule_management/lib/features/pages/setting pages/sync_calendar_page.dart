import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_schedule_management/config/text_styles/app_text_style.dart';

class SyncCalendarPage extends StatelessWidget {
  const SyncCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Đồng bộ hóa lịch trình')),
      body: Column(children: [
        Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(FontAwesomeIcons.userLarge),
              radius: 30,
            ),
            title: Text(
              'Tên người dùng',
              style: AppTextStyle.h2_5,
            ),
            subtitle: Text('Nhấp để đăng nhập'),
          ),
        ),
        ListTile(
          title: Text('Đồng bộ hóa dữ liệu'),
          subtitle: Text('Chưa đồng bộ hóa'),
          trailing: FilledButton(
            onPressed: () {},
            child: Text('Đồng bộ'),
          ),
        )
      ]),
    );
  }
}
