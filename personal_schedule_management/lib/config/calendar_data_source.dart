import 'package:syncfusion_flutter_calendar/calendar.dart';

class MyCalendarDataSource extends CalendarDataSource {
  MyCalendarDataSource(List<Appointment> data) {
    appointments = data;
  }
}
