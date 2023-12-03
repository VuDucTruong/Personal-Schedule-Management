import 'package:flutter/material.dart';

import '../../config/text_styles/app_text_style.dart';
import '../controller/calendar_controller.dart';
import '../widgets/stateless/calendar_day_widget.dart';
import '../widgets/stateless/calendar_month_widget.dart';
import '../widgets/stateless/calendar_schedule_widget.dart';
import '../widgets/stateless/calendar_week_widget.dart';
import 'create_work_page.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});
  static final String routeName = 'calendarpage';

  @override
  _CalendarPageState createState() {
    return _CalendarPageState();
  }
}

class _CalendarPageState extends State<CalendarPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  late CalendarPageController calendarPageController = CalendarPageController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  void reloadPage() {
    setState(() {
      calendarPageController.times = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('build!');
    return Scaffold(
      body: Column(children: [
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
        FutureBuilder(
          future: calendarPageController.getCalendarEvents(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.hasData) {
              calendarPageController.getCalendarDatasource();
              return Expanded(
                  child: TabBarView(
                      controller: tabController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                    CalendarSchedule(
                        calendarPageController.calendarDatasource, reloadPage),
                    CalendarDay(
                        calendarPageController.calendarDatasource, reloadPage),
                    CalendarWeek(
                        calendarPageController.calendarDatasource, reloadPage),
                    CalendarMonth(
                        calendarPageController.calendarDatasource, reloadPage)
                  ]));
            } else
              return CircularProgressIndicator();
          },
        ),
      ]),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 4),
        child: FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
            child: Icon(Icons.add),
            onPressed: () async {
              bool? result = await showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return CreateWorkPage(null);
                },
              );
              if (result != null && result) {
                setState(() {
                  calendarPageController.times = 0;
                });
              }
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
