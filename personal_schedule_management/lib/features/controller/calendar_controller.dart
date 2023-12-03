import 'package:device_calendar/device_calendar.dart';
import 'package:get_it/get_it.dart';
import 'package:personal_schedule_management/config/calendar_data_source.dart';
import 'package:personal_schedule_management/core/domain/repository_impl/completed_work_respository_impl.dart';
import 'package:personal_schedule_management/core/domain/repository_impl/notification_respository_impl.dart';
import 'package:personal_schedule_management/core/domain/repository_impl/work_respository_impl.dart';
import 'package:personal_schedule_management/notification_services.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../config/theme/app_theme.dart';
import '../../core/domain/entity/cong_viec_entity.dart';
import '../../core/domain/entity/thong_bao_entity.dart';

class CalendarPageController {
  List<Appointment> appointmentList = [];
  int times = 0;
  late MyCalendarDataSource calendarDatasource;
  final DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();
  WorkRespositoryImpl workRespositoryImpl =
      GetIt.instance<WorkRespositoryImpl>();
  CompletedWorkRespositoryImpl completedWorkRespositoryImpl =
      GetIt.instance<CompletedWorkRespositoryImpl>();
  NotificationRespositoryImpl notificationRespositoryImpl =
      GetIt.instance<NotificationRespositoryImpl>();
  NotificationServices notificationServices =
      GetIt.instance<NotificationServices>();
  bool isWeatherVisible = true;

  Future<bool> getCalendarEvents() async {
    appointmentList = [];

    await loadAppointment();
    if (times++ >= 1) {
      return true;
    }
    final calendarsResult = (await deviceCalendarPlugin.retrieveCalendars());
    final List<Calendar> calendars = calendarsResult.data as List<Calendar>;
    List<String> calendarIds = [];
    List<Calendar> calendarSingleList = [];
    createCalendarWithoutDuplicated(calendars, calendarSingleList);
    for (Calendar calendar in calendarSingleList) {
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
          notes: '0',
          location: event.location,
          color: lightColorScheme.primary));
    }
    return true;
  }

  CalendarPageController() {}

  Future<void> getCalendarDatasource() async {
    calendarDatasource = MyCalendarDataSource(appointmentList);
    List<Appointment> appointments =
        calendarDatasource.getVisibleAppointments(DateTime.now(), '');
    notificationServices.cancelNotification();
    for (Appointment i in appointments) {
      List<ThongBao> thongBao = await notificationRespositoryImpl
          .getNotificationByWorkId(i.id.toString());
      for (ThongBao j in thongBao) {
        DateTime time = i.startTime.subtract(j.thoiGian);
        if (time.isBefore(DateTime.now())) continue;
        await notificationServices.createNotification(i, time, j.maTB);
      }
      ;
    }
  }

  Future<List<Event>> retrieveEvents(List<String> calendarIds) async {
    List<Event> events = [];
    DateTime startDate = DateTime(2023);
    DateTime endDate = DateTime(2024);
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

  void createCalendarWithoutDuplicated(
      List<Calendar> calendarList, List<Calendar> newList) {
    Set<String?> accountNameSet = Set();
    calendarList.forEach((element) {
      if (!accountNameSet.contains(element.accountName)) {
        accountNameSet.add(element.accountName);
        newList.add(element);
      }
    });
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
        notes: '1');
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
