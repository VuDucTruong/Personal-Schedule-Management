import 'package:flutter/material.dart';
import 'package:personal_schedule_management/config/calendar_data_source.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarDay extends StatelessWidget {
  List<Appointment> data_source;

  CalendarDay(this.data_source, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: SfCalendar(
      view: CalendarView.day,
      dataSource: GetCalendarDataSource(data_source),
    ));
  }
}
