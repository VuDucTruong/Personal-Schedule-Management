import 'package:device_calendar/device_calendar.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:personal_schedule_management/core/domain/repository_impl/completed_work_respository_impl.dart';
import 'package:personal_schedule_management/core/domain/repository_impl/notification_respository_impl.dart';
import 'package:personal_schedule_management/core/domain/repository_impl/work_respository_impl.dart';
import 'package:personal_schedule_management/notification_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../config/theme/app_theme.dart';
import '../../core/constants/constants.dart';
import '../../core/domain/entity/cong_viec_entity.dart';
import '../../core/domain/entity/thong_bao_entity.dart';

class CalendarPageController {
  List<Appointment> appointmentList = [];
  int times = 0;

  final DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();
  WorkRespositoryImpl workRespositoryImpl =
      GetIt.instance<WorkRespositoryImpl>();
  CompletedWorkRespositoryImpl completedWorkRespositoryImpl =
      GetIt.instance<CompletedWorkRespositoryImpl>();
  NotificationRespositoryImpl notificationRespositoryImpl =
      GetIt.instance<NotificationRespositoryImpl>();
  bool isWeatherVisible = true;

  Future<bool> getCalendarEvents() async {
    if (times++ > 0) return false;
    appointmentList = [];
    await loadAppointment();
    final calendarsResult = (await deviceCalendarPlugin.retrieveCalendars());
    if (calendarsResult.data != null) {
      final List<Calendar> calendars = calendarsResult.data as List<Calendar>;
      List<String> calendarIds = [];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> banList = prefs.getStringList(BAN_ACCOUNT) ?? [];
      for (Calendar calendar in calendars) {
        if (banList.contains(calendar.id)) continue;
        calendarIds.add(calendar.id.toString());
      }
      List<Event> eventList = await retrieveEvents(calendarIds);
      for (Event event in eventList) {
        appointmentList.add(Appointment(
            id: event.eventId,
            startTime: DateTime.parse(event.start.toString()),
            endTime: DateTime.parse(event.end.toString()),
            isAllDay: event.allDay!,
            subject: event.title!,
            notes: '0|2|0', //is ReadOnly - priority - is alarm
            recurrenceRule: null,
            location: event.location,
            color: SchemeLight_default.primary));
      }
    }
    return true;
  }

  Future<List<Event>> retrieveEvents(List<String> calendarIds) async {
    List<Event> events = [];
    DateTime startDate = DateTime(DateTime.now().year - 1);
    DateTime endDate = DateTime(DateTime.now().year + 1);
    RetrieveEventsParams params = RetrieveEventsParams(
      startDate: startDate,
      endDate: endDate,
    );
    for (String id in calendarIds) {
      Result<List<Event>> eventsResult =
          await deviceCalendarPlugin.retrieveEvents(id, params);
      if (eventsResult.isSuccess && eventsResult.data != null) {
        events.addAll(eventsResult.data!);
      } else {
        // Xử lý lỗi
        print('Lỗi khi lấy danh sách sự kiện: ${eventsResult.errors}');
      }
    }
    return events;
  }

  void changeWeatherVisibility() {
    isWeatherVisible = !isWeatherVisible;
  }

  //TODO
  Future<void> _createAppointment(CongViec congViec) async {
    String? rule;
    rule = congViec.thoiDiemLap;
    Appointment appointment = Appointment(
        startTime: congViec.ngayBatDau,
        endTime: congViec.ngayKetThuc,
        subject: congViec.tieuDe,
        color: congViec.mauSac,
        isAllDay: congViec.isCaNgay,
        id: congViec.maCV,
        recurrenceRule: rule,
        location: congViec.diaDiem,
        recurrenceExceptionDates: congViec.ngayNgoaiLe,
        notes: '1|${congViec.doUuTien}|${congViec.isBaoThuc}');
    //if (appointmentList.contains(appointment)) return;
    appointmentList.add(appointment);
  }

  Future<void> loadAppointment() async {
    List<CongViec> congViecList =
        await workRespositoryImpl.getAllCongViecByUserId('');
    for (var element in congViecList) {
      await _createAppointment(element);
    }
  }
}
