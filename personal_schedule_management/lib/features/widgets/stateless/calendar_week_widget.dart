import 'package:flutter/material.dart';
import 'package:personal_schedule_management/config/calendar_data_source.dart';
import 'package:personal_schedule_management/core/constants/constants.dart';
import 'package:personal_schedule_management/features/controller/calendar_schedule_controller.dart';
import 'package:personal_schedule_management/features/controller/settings_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// ignore: must_be_immutable
class CalendarWeek extends StatelessWidget {
  CalendarWeek(this.dataSource, this.setStateCallback, {super.key});
  MyCalendarDataSource dataSource;
  VoidCallback setStateCallback;
  CalendarScheduleController calendarScheduleController =
      CalendarScheduleController();

  SettingsController settingsController = SettingsController();
  bool is24hFormat = false;
  bool hasCalledGetData = false;

  Future<void> getData() async {
    is24hFormat = await settingsController.GetTime24hFormatSetting() ?? false;
    print(is24hFormat);
    hasCalledGetData = true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            TimeSlotViewSettings timeSlotViewSettings = TimeSlotViewSettings(
              timeFormat: is24hFormat
                  ? AppDateFormat.TIME_24H
                  : AppDateFormat.TIME_12H, //hiển thị giờ theo định dạng
            );
            return Container(
              child: SfCalendar(
                view: CalendarView.week,
                dataSource: dataSource,
                timeSlotViewSettings: timeSlotViewSettings,
                onTap: (details) async {
                  //calendarScheduleController.showWorkDetails(context, details.)
                  if ((details.appointments?.length ?? 5) == 1 &&
                      details.date != null) {
                    Appointment appointment = details.appointments!.first;
                    await calendarScheduleController.showWorkDetails(
                        context, appointment, () => setStateCallback());
                  }
                },
              ),
            );
          }
          return CircularProgressIndicator();
        });
  }
}
