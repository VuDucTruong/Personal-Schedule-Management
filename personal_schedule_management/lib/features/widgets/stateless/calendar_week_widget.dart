import 'package:flutter/material.dart';
import 'package:personal_schedule_management/config/calendar_data_source.dart';
import 'package:personal_schedule_management/features/controller/calendar_schedule_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWeek extends StatelessWidget {
  CalendarWeek(this.dataSource, this.setStateCallback, {super.key});
  MyCalendarDataSource dataSource;
  VoidCallback setStateCallback;
  CalendarScheduleController calendarScheduleController =
      CalendarScheduleController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: SfCalendar(
        view: CalendarView.week,
        dataSource: dataSource,
        onTap: (details) async {
          //calendarScheduleController.showWorkDetails(context, details.)
          if ((details.appointments?.length ?? 5) == 1 &&
              details.date != null) {
            Appointment appointment = details.appointments!.first;
            await calendarScheduleController.showWorkDetails(
                context, appointment, () => setStateCallback());
          }
        },
      ),
    );
  }
}
