import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:personal_schedule_management/core/domain/entity/my_appointment.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../core/domain/repository_impl/work_respository_impl.dart';

class CalendarSchedule extends StatelessWidget {
  CalendarSchedule(this.dataSource, this.setStateCallback, {super.key});
  CalendarDataSource dataSource;
  final VoidCallback setStateCallback;
  final DateFormat timeFormat = DateFormat("hh:mm a", 'vi_VN');
  final Map<int, String> monthMap = {
    1: 'January',
    2: 'February',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'July',
    8: 'August',
    9: 'September',
    10: 'October',
    11: 'November',
    12: 'December',
  };
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: SfCalendar(
      view: CalendarView.schedule,
      scheduleViewSettings: ScheduleViewSettings(
        appointmentItemHeight: 70,
      ),
      dataSource: dataSource,
      onTap: (details) {
        print(details.targetElement);
      },
      scheduleViewMonthHeaderBuilder:
          (BuildContext buildContext, ScheduleViewMonthHeaderDetails details) {
        final String monthName = monthMap[details.date.month]!;
        return Stack(
          children: [
            Image(
                image: AssetImage('assets/image/' + monthName + '.jpg'),
                fit: BoxFit.cover,
                width: details.bounds.width,
                height: details.bounds.height),
            Positioned(
              left: 55,
              right: 0,
              top: 20,
              bottom: 0,
              child: Text(
                monthName + ' ' + details.date.year.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          ],
        );
      },
      appointmentBuilder: (context, calendarAppointmentDetails) {
        MyAppointment appointment =
            calendarAppointmentDetails.appointments.first as MyAppointment;
        Duration duration = DateTime(appointment.startTime.year,
                appointment.startTime.month, appointment.startTime.day)
            .difference(DateTime(
                calendarAppointmentDetails.date.year,
                calendarAppointmentDetails.date.month,
                calendarAppointmentDetails.date.day));
        Duration duration2 = DateTime(appointment.endTime.year,
                appointment.endTime.month, appointment.endTime.day)
            .difference(DateTime(appointment.endTime.year,
                appointment.startTime.month, appointment.startTime.day));
        String durationString = '';
        if (duration2.inDays > 0) {
          durationString =
              '(${-duration.inDays + 1} / ${duration2.inDays + 1})';
        }
        return Card(
          color: appointment.color,
          child: Container(
            margin: EdgeInsets.all(8),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 190,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                appointment.subject,
                                style: TextStyle(
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                            SizedBox(
                              width: 50,
                              child: Text(
                                '  $durationString',
                                style: TextStyle(
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            )
                          ]),
                    ),
                    Builder(
                      builder: (context) {
                        if (appointment.isAllDay) {
                          return Text(
                            'Cả ngày',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          );
                        } else {
                          return Text(
                            '${timeFormat.format(appointment.startTime)} - ${timeFormat.format(appointment.endTime)}',
                            style: TextStyle(color: Colors.white),
                          );
                        }
                      },
                    ),
                  ],
                ),
                Spacer(),
                if (durationString.isNotEmpty)
                  Icon(
                    Icons.double_arrow_outlined,
                    color: Colors.white,
                  ),
                SizedBox(
                  width: 4,
                ),
                if (appointment.recurrenceRule != null)
                  Icon(
                    Icons.event_repeat_rounded,
                    color: Colors.white,
                  ),
                SizedBox(
                  width: 4,
                ),
                Visibility(
                  visible: appointment.isDeletePermisson,
                  child: InkWell(
                    child: Icon(FontAwesomeIcons.xmark),
                    onTap: () async {
                      await GetIt.instance<WorkRespositoryImpl>()
                          .deleteWorkById(appointment.id.toString());
                      dataSource.notifyListeners(
                          CalendarDataSourceAction.remove, [appointment]);
                      setStateCallback();
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    ));
  }
}
