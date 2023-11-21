import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:personal_schedule_management/config/theme/app_theme.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPageController extends ChangeNotifier {
  late List<Appointment> appointmentList = [];
  final DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();
  bool isWeatherVisible = true;
  Future<void> getCalendarEvents() async {
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
          notes: event.description,
          location: event.location,
          color: lightColorScheme.primary));
    }
    notifyListeners();
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
    notifyListeners();
  }
}
