import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:personal_schedule_management/config/calendar_data_source.dart';
import 'package:personal_schedule_management/core/domain/entity/cong_viec_ht_entity.dart';
import 'package:personal_schedule_management/features/controller/calendar_schedule_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../core/domain/repository_impl/work_respository_impl.dart';

class CalendarSchedule extends StatefulWidget {
  CalendarSchedule(this.dataSource, this.setStateCallback, {super.key});
  MyCalendarDataSource dataSource;
  final VoidCallback setStateCallback;

  @override
  State<CalendarSchedule> createState() => _CalendarScheduleState();
}

class _CalendarScheduleState extends State<CalendarSchedule> {
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

  CalendarScheduleController calendarScheduleController =
      CalendarScheduleController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: SfCalendar(
      view: CalendarView.schedule,
      scheduleViewSettings: ScheduleViewSettings(
        appointmentItemHeight: 70,
      ),
      dataSource: widget.dataSource,
      onTap: (details) async {
        //calendarScheduleController.showWorkDetails(context, details.)
        /*if ((details.appointments?.length ?? 5) == 1 && details.date != null) {
          Appointment appointment = details.appointments!.first;
          await calendarScheduleController.showWorkDetails(
              context,
              appointment.id.toString(),
              details.date!,
              () => widget.setStateCallback());
        }*/
        print(details.appointments?.first);
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
        Appointment appointment =
            calendarAppointmentDetails.appointments.first as Appointment;
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
        int? isFinished = (int.tryParse(appointment.notes![2]));
        return FutureBuilder(
          future: calendarScheduleController.getCompletedWork(
              appointment.id.toString(), appointment.startTime),
          builder: (context, snapshot) {
            CongViecHT? congViecHT = snapshot.data;
            return Card(
              color: appointment.color,
              child: Container(
                margin: EdgeInsets.all(8),
                child: Row(
                  children: [
                    if (isFinished != null)
                      Checkbox(
                          value: (congViecHT != null ? 1 : 0) > 0,
                          onChanged: (value) async {
                            if (value != null) {
                              if (value) {
                                await calendarScheduleController
                                    .addCompletedWork(appointment);
                              } else {
                                await calendarScheduleController
                                    .removeCompletedWork(
                                        appointment.id.toString(),
                                        appointment.startTime);
                              }
                              setState(() {});
                            }
                          }),
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
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
                    Visibility(
                      visible: appointment.notes?[0] == '1',
                      child: InkWell(
                        child: Icon(FontAwesomeIcons.xmark),
                        onTap: () async {
                          await GetIt.instance<WorkRespositoryImpl>()
                              .deleteWorkById(appointment.id.toString());
                          widget.dataSource.notifyListeners(
                              CalendarDataSourceAction.remove, [appointment]);
                          widget.setStateCallback();
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
        return Container();
      },
    ));
  }
}
