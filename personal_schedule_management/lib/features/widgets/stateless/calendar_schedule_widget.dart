import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../config/calendar_data_source.dart';

class CalendarSchedule extends StatelessWidget {
  CalendarSchedule(this.data_source, {super.key});

  List<Appointment> data_source;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: SfCalendar(
        view: CalendarView.schedule,
        scheduleViewSettings: ScheduleViewSettings(
          appointmentItemHeight: 70,
        ),
        dataSource: GetCalendarDataSource(data_source),
      ),
    );
  }
}
