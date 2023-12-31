import 'package:device_calendar/device_calendar.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:personal_schedule_management/core/domain/repository_impl/work_respository_impl.dart';
import 'package:personal_schedule_management/notification_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../config/theme/app_theme.dart';
import '../../core/constants/constants.dart';
import '../../core/domain/entity/cong_viec_entity.dart';
import '../../core/domain/entity/thong_bao_entity.dart';

class CalendarPageController {
  List<Appointment> _appointmentList = [];
  List<Appointment> _calendarAppointmentList = [];
  List<Appointment> get appointmentList {
    return _calendarAppointmentList + _appointmentList;
  }
  int times = 0;

  final DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();
  WorkRespositoryImpl workRespositoryImpl =
      GetIt.instance<WorkRespositoryImpl>();
  bool isWeatherVisible = true;
  static bool _isSyncCalendarModified = true;
  static bool get isSyncCalendarModified {
    return _isSyncCalendarModified;
  }
  static set isSyncCalendarModified (bool value) {
    _isSyncCalendarModified = value;
  }

  Future<bool> getCalendarEvents() async {
    if (times++ > 0) return false;
    _appointmentList = [];
    await getSyncCalendarEvents();
    await loadAppointment();
    return true;
  }

  Future<bool> getSyncCalendarEvents() async {
    if (!isSyncCalendarModified){
      return false;
    }
    print('Sync Google Calendar!');
    _calendarAppointmentList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? syncCalendar = prefs.getBool(SYNC);
    // fresh start
    if (syncCalendar == null){
      await deviceCalendarPlugin.requestPermissions();
      bool isSync = await Permission.calendarFullAccess.isGranted;
      prefs.setBool(SYNC, isSync);
      if (isSync == false){
        return false;
      }
    } else
    // no sync
    if (!syncCalendar) {
      print('Sync off');
      isSyncCalendarModified = false;
      return false;
    }
    print('Sync on!');
    final calendarsResult = (await deviceCalendarPlugin.retrieveCalendars());
    if (calendarsResult.data != null) {
      final List<Calendar> calendars = calendarsResult.data as List<Calendar>;
      List<String> calendarIds = [];
      List<String> banList = prefs.getStringList(BAN_ACCOUNT) ?? [];
      for (Calendar calendar in calendars) {
        if (banList.contains(calendar.id)) continue;
        calendarIds.add(calendar.id.toString());
      }
      List<Event> eventList = await retrieveEvents(calendarIds);
      for (Event event in eventList) {
        _calendarAppointmentList.add(Appointment(
            id: event.eventId,
            startTime: DateTime.parse(event.start.toString()),
            endTime: DateTime.parse(event.end.toString()),
            isAllDay: event.allDay!,
            subject: event.title!,
            notes: '0|3|0', //is ReadOnly - priority - is alarm
            recurrenceRule: null,
            location: event.location,
            color: SchemeLight_default.primary));
      }
    }
    isSyncCalendarModified = false;
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
    _appointmentList.add(appointment);
  }

  Future<void> loadAppointment() async {
    List<CongViec> congViecList =
        await workRespositoryImpl.getAllCongViecByUserId('');
    for (var element in congViecList) {
      await _createAppointment(element);
    }
  }
}
