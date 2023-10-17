import 'package:syncfusion_flutter_calendar/calendar.dart';

class GetCalendarDataSource extends CalendarDataSource {
  GetCalendarDataSource(List<Appointment> data) {
    appointments = data;
  }
}
