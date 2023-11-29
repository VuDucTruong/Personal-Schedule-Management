import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:personal_schedule_management/config/calendar_data_source.dart';
import 'package:personal_schedule_management/features/controller/calendar_schedule_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../core/domain/entity/cong_viec_ht_entity.dart';
import '../../../core/domain/repository_impl/work_respository_impl.dart';

class CalendarMonth extends StatefulWidget {
  CalendarMonth(this.dataSource, this.setStateCallback, {super.key});
  MyCalendarDataSource dataSource;
  final VoidCallback setStateCallback;

  @override
  State<CalendarMonth> createState() => _CalendarMonthState();
}

class _CalendarMonthState extends State<CalendarMonth> {
  final DateFormat timeFormat = DateFormat("hh:mm a", 'vi_VN');
  CalendarScheduleController calendarScheduleController =
      CalendarScheduleController();

  @override
  void initState() {
    super.initState();
    calendarScheduleController.getAllCompletedWork(() {
      setState(() {});
    });
  }

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
        int? isFinished = (int.tryParse(appointment.notes![0]));
        CongViecHT? congViecHT;
        if (calendarScheduleController.congViecHTMap.isNotEmpty) {
          congViecHT = calendarScheduleController
              .congViecHTMap['${appointment.id}-${appointment.startTime}'];
        }
        return InkWell(
          onTap: () async {
            Appointment appointment =
                calendarAppointmentDetails.appointments.first;
            await calendarScheduleController
                .showWorkDetails(context, appointment, () {
              calendarScheduleController.getAllCompletedWork(() {
                setState(() {});
              });
              widget.setStateCallback();
            });
          },
          child: Card(
            color: appointment.color,
            child: Container(
              margin: EdgeInsets.all(8),
              child: Row(
                children: [
                  if (isFinished == 1)
                    Checkbox(
                        value: calendarScheduleController
                                .checkBoxMap['${appointment.startTime}'] ??
                            false,
                        onChanged: (value) async {
                          if (value != null) {
                            setState(() {
                              calendarScheduleController
                                      .checkBoxMap['${appointment.startTime}'] =
                                  value;
                            });
                            if (value) {
                              await calendarScheduleController
                                  .addCompletedWork(appointment);
                            } else {
                              await calendarScheduleController
                                  .removeCompletedWork(
                                      appointment.id.toString(),
                                      appointment.startTime);
                            }
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
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
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
                    visible: isFinished == 1,
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
          ),
        );
      },
      dataSource: widget.dataSource,
    );
  }
}
