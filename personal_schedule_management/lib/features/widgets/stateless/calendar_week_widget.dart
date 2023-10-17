import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../config/calendar_data_source.dart';

class CalendarWeek extends StatelessWidget {
  CalendarWeek(this.data_source, {super.key});

  List<Appointment> data_source;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: SfCalendar(
        view: CalendarView.week,
        dataSource: GetCalendarDataSource(data_source),
      ),
    );
  }
}
