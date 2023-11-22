import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWeek extends StatelessWidget {
  CalendarWeek(this.dataSource, {super.key});
  CalendarDataSource dataSource;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: SfCalendar(
        view: CalendarView.week,
        dataSource: dataSource,
      ),
    );
  }
}
