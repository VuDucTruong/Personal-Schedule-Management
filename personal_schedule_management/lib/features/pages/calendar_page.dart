import 'package:flutter/material.dart';
import 'package:personal_schedule_management/config/text_styles/app_text_style.dart';
import 'package:personal_schedule_management/features/widgets/stateless/calendar_day_widget.dart';
import 'package:personal_schedule_management/features/widgets/stateless/calendar_month_widget.dart';
import 'package:personal_schedule_management/features/widgets/stateless/calendar_schedule_widget.dart';
import 'package:personal_schedule_management/features/widgets/stateless/calendar_week_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() {
    return _CalendarPageState();
  }
}

class _CalendarPageState extends State<CalendarPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  List<Appointment> getAppointments() {
    List<Appointment> appointments = <Appointment>[];
    // Tạo các sự kiện (appointments)
    appointments.add(Appointment(
      startTime: DateTime(2023, 9, 19, 10, 0),
      endTime: DateTime(2023, 9, 19, 12, 0),
      subject: 'Meeting',
      color: Colors.blue,
    ));
    appointments.add(Appointment(
      startTime: DateTime(2023, 9, 19, 14, 0),
      endTime: DateTime(2023, 9, 19, 15, 0),
      subject: 'Meeting',
      color: Colors.black,
    ));
    appointments.add(Appointment(
      startTime: DateTime(2023, 9, 20, 10, 0),
      endTime: DateTime(2023, 9, 20, 12, 0),
      subject: 'Meeting',
      color: Colors.yellow,
    ));
    // Thêm các sự kiện khác vào danh sách appointments ở đây

    return appointments;
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          TabBar(
            controller: tabController,
            tabs: [
              TabItem('Lịch biểu'),
              TabItem('Ngày'),
              TabItem('Tuần'),
              TabItem('Tháng'),
            ],
            onTap: (value) => tabController.animateTo(value),
          ),
          Expanded(
            child: TabBarView(
                controller: tabController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  CalendarSchedule(getAppointments()),
                  CalendarDay(getAppointments()),
                  CalendarWeek(getAppointments()),
                  CalendarMonth(getAppointments())
                ]),
          ),
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 4),
        child: FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
            child: Icon(Icons.add),
            onPressed: () {
              print(getAppointments().length);
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

class TabItem extends StatelessWidget {
  String content;
  TabItem(
    this.content, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        content,
        textAlign: TextAlign.center,
        style: AppTextStyle.h3,
      ),
    );
  }
}
