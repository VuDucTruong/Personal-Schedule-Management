import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:personal_schedule_management/core/domain/entity/my_appointment.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../core/domain/repository_impl/work_respository_impl.dart';

class CalendarMonth extends StatelessWidget {
  CalendarMonth(this.dataSource, this.setStateCallback, {super.key});
  CalendarDataSource dataSource;
  final VoidCallback setStateCallback;
  final DateFormat timeFormat = DateFormat("hh:mm a", 'vi_VN');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SfCalendar(
      view: CalendarView.month,
      monthViewSettings: MonthViewSettings(
          showAgenda: true,
          agendaItemHeight: 65,
          monthCellStyle: MonthCellStyle(
            todayBackgroundColor: Theme.of(context).colorScheme.primary,
          )),
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
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      SizedBox(
                        width: 130,
                        child: Text(
                          appointment.subject,
                          style: TextStyle(
                              color: Colors.white,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        child: Text(
                          '   $durationString',
                          style: TextStyle(
                              color: Colors.white,
                              overflow: TextOverflow.ellipsis),
                        ),
                      )
                    ]),
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
      dataSource: dataSource,
    );
  }
}
