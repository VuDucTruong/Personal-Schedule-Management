import 'package:device_calendar/device_calendar.dart';
import 'package:get_it/get_it.dart';
import 'package:personal_schedule_management/config/calendar_data_source.dart';
import 'package:personal_schedule_management/core/domain/entity/chu_ky_entity.dart';
import 'package:personal_schedule_management/core/domain/entity/my_appointment.dart';
import 'package:personal_schedule_management/core/domain/repository_impl/recurrence_respository_impl.dart';
import 'package:personal_schedule_management/core/domain/repository_impl/work_respository_impl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../config/theme/app_theme.dart';
import '../../core/domain/entity/cong_viec_entity.dart';

class CalendarPageController {
  List<MyAppointment> appointmentList = [];
  int times = 0;
  late CalendarDataSource calendarDatasource;
  final DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();
  WorkRespositoryImpl workRespositoryImpl =
      GetIt.instance<WorkRespositoryImpl>();
  RecurrenceRespositoryImpl recurrenceRespositoryImpl =
      GetIt.instance<RecurrenceRespositoryImpl>();
  bool isWeatherVisible = true;

  Future<bool> getCalendarEvents() async {
    appointmentList = [];
    /*if (times++ >= 1) {
      print('Đã quá giới hạn ! $times');
      return true;
    }*/
    await loadAppointment();
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
      appointmentList.add(MyAppointment(
          id: event.eventId,
          startTime: DateTime.parse(event.start.toString()),
          endTime: DateTime.parse(event.end.toString()),
          isAllDay: event.allDay!,
          subject: event.title!,
          notes: '0',
          location: event.location,
          url: event.url.toString(),
          isDeletePermisson: false,
          color: lightColorScheme.primary));
    }
    return true;
  }

  CalendarPageController() {}

  void getCalendarDatasource() {
    calendarDatasource = GetCalendarDataSource(appointmentList);
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

  Future<void> _createAppointment(CongViec congViec, String maCK) async {
    String? rule;
    if (maCK.isNotEmpty) {
      ChuKy? chuKy = await recurrenceRespositoryImpl.getChuKyById(maCK);
      if (chuKy != null) {
        rule = chuKy.thoiDiemLap;
      }
    }
    MyAppointment appointment = MyAppointment(
      startTime: congViec.ngayBatDau,
      endTime: congViec.ngayKetThuc,
      subject: congViec.tieuDe,
      color: congViec.mauSac,
      isAllDay: congViec.isCaNgay,
      id: congViec.maCV,
      recurrenceRule: rule,
      location: congViec.diaDiem,
    );
    //if (appointmentList.contains(appointment)) return;
    appointmentList.add(appointment);
  }

  Future<void> loadAppointment() async {
    List<CongViec> congViecList =
        await workRespositoryImpl.getAllCongViecByUserId('');
    for (var element in congViecList) {
      await _createAppointment(element, element.maCK);
    }
  }
}
