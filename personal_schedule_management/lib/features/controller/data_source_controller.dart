import 'package:personal_schedule_management/config/calendar_data_source.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DataSourceController {
  late CalendarDataSource calendarDataSource;
  late List<Appointment> _appointmentList;

  DataSourceController();

  List<Appointment> get appointmentList => _appointmentList;

  set appointmentList(List<Appointment> value) {
    _appointmentList = value;
    calendarDataSource = MyCalendarDataSource(_appointmentList);
  }

  void insertAppointment(Appointment x) {
    appointmentList.add(x);
    calendarDataSource.notifyListeners(
        CalendarDataSourceAction.add, appointmentList);
  }

  void removeAppointment(Appointment x) {
    appointmentList.remove(x);
    calendarDataSource.notifyListeners(
        CalendarDataSourceAction.remove, appointmentList);
  }

  void updateAppointment(Appointment x) {
    appointmentList.removeWhere((element) => element.id == x.id);
    appointmentList.add(x);
    calendarDataSource.notifyListeners(
        CalendarDataSourceAction.reset, appointmentList);
  }
}
