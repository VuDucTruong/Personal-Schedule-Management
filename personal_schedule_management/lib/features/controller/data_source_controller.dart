import 'package:get_it/get_it.dart';
import 'package:personal_schedule_management/config/calendar_data_source.dart';
import 'package:personal_schedule_management/core/domain/repository_impl/notification_respository_impl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../core/domain/entity/thong_bao_entity.dart';
import '../../notification_services.dart';

class DataSourceController {
  late CalendarDataSource calendarDataSource;
  late List<Appointment> _appointmentList;
  NotificationServices notificationServices =
      GetIt.instance<NotificationServices>();
  NotificationRespositoryImpl notificationRespositoryImpl =
      GetIt.instance<NotificationRespositoryImpl>();
  DataSourceController();

  List<Appointment> get appointmentList => _appointmentList;

  set appointmentList(List<Appointment> value) {
    _appointmentList = value;
    calendarDataSource = MyCalendarDataSource(_appointmentList);
    calendarDataSource.addListener((p0, p1) {
      setUpNotification();
    });
  }

  void insertAppointment(Appointment x) {
    appointmentList.add(x);
    calendarDataSource.notifyListeners(CalendarDataSourceAction.add, [x]);
  }

  void removeAppointment(Appointment x) {
    appointmentList.remove(x);
    calendarDataSource.notifyListeners(CalendarDataSourceAction.remove, [x]);
  }

  void updateAppointment(Appointment x) {
    appointmentList.removeWhere((element) => element.id == x.id);
    appointmentList.add(x);
    calendarDataSource.notifyListeners(
        CalendarDataSourceAction.reset, appointmentList);
  }

  Future<void> setUpNotification() async {
    List<Appointment> appointments = calendarDataSource.getVisibleAppointments(
        DateTime.now(), '', DateTime.now().add(const Duration(days: 2)));
    notificationServices.cancelNotification();
    for (Appointment i in appointments) {
      List<ThongBao> thongBao = await notificationRespositoryImpl
          .getNotificationByWorkId(i.id.toString());
      for (ThongBao j in thongBao) {
        DateTime time = i.startTime.subtract(j.thoiGian);
        if (time.isBefore(DateTime.now())) continue;
        await notificationServices.createNotification(
            i, time, j.maTB, bool.tryParse(i.notes![4]) ?? false);
      }
    }
  }
}
