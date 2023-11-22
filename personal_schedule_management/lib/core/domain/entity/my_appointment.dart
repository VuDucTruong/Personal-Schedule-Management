import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MyAppointment extends Appointment {
  MyAppointment(
      {super.startTimeZone,
      super.endTimeZone,
      super.recurrenceRule,
      super.isAllDay = false,
      super.notes,
      super.location,
      super.resourceIds,
      super.recurrenceId,
      super.id,
      required super.startTime,
      required super.endTime,
      super.subject = '',
      super.color = Colors.lightBlue,
      super.recurrenceExceptionDates,
      this.isDeletePermisson = true,
      this.url});
  bool isDeletePermisson;
  String? url;
}
