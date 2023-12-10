import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:personal_schedule_management/config/calendar_data_source.dart';
import 'package:personal_schedule_management/features/controller/calendar_schedule_controller.dart';
import 'package:personal_schedule_management/features/controller/data_source_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../config/text_styles/app_text_style.dart';
import '../../config/theme/app_theme.dart';
import '../../core/constants/constants.dart';
import '../../core/data/datasource/remote/api_services.dart';
import '../../core/data/dto/forecast_weather_dto.dart';
import '../../core/data/dto/weather_dto.dart';
import '../../core/data/dto/weather_location_dto.dart';
import '../controller/calendar_controller.dart';
import '../widgets/stateless/delete_dialog.dart';
import 'create_work_page.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() {
    return _CalendarPageState();
  }
}

class _CalendarPageState extends State<CalendarPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  late CalendarPageController calendarPageController = CalendarPageController();
  CalendarScheduleController calendarScheduleController =
      CalendarScheduleController();
  CalendarController calendarController = CalendarController();
  DataSourceController dataSourceController =
      GetIt.instance<DataSourceController>();
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    getAllCompleteWork();
  }

  @override
  void dispose() {
    super.dispose();
    calendarController.dispose();
  }

  void reloadPage() {
    setState(() {
      calendarPageController.times = 0;
    });
  }

  void getAllCompleteWork() {
    calendarScheduleController.getAllCompletedWork(
      () {
        setState(() {
          //isNeedSetUp = true;
        });
      },
    );
  }

  bool isNeedSetUp = true;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('build!');
    return Scaffold(
      drawer: MyDrawer(calendarController),
      appBar: AppBar(
        title: Text('Lịch'),
        actions: [
          //Search
          IconButton(
              onPressed: () async {
                await showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(
                      dataSourceController.calendarDataSource,
                      calendarScheduleController,
                      context,
                      getAllCompleteWork),
                );
                setState(() {});
              },
              icon: Icon(FontAwesomeIcons.magnifyingGlass)),
          //Add
          IconButton(
              onPressed: () async {
                await showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return CreateWorkPage(null);
                  },
                );
              },
              icon: Icon(Icons.add_circle)),
        ],
      ),
      body: FutureBuilder(
        future: calendarPageController.getCalendarEvents(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.hasData) {
            if (isNeedSetUp) {
              dataSourceController.appointmentList =
                  calendarPageController.appointmentList;
              isNeedSetUp = false;
            }
            calendarPageController
                .setUpNotification(dataSourceController.calendarDataSource);
            return SfCalendar(
              controller: calendarController,
              view: CalendarView.schedule,
              scheduleViewSettings: ScheduleViewSettings(
                appointmentItemHeight: 70,
              ),
              monthViewSettings: MonthViewSettings(
                  showAgenda: true,
                  agendaItemHeight: 65,
                  monthCellStyle: MonthCellStyle(
                    todayBackgroundColor: Theme.of(context).colorScheme.primary,
                  )),
              dataSource: dataSourceController.calendarDataSource,
              scheduleViewMonthHeaderBuilder: (BuildContext buildContext,
                  ScheduleViewMonthHeaderDetails details) {
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                );
              },
              appointmentBuilder: (context, calendarAppointmentDetails) {
                Appointment appointment = calendarAppointmentDetails
                    .appointments.first as Appointment;
                Duration duration = DateTime(appointment.startTime.year,
                        appointment.startTime.month, appointment.startTime.day)
                    .difference(DateTime(
                        calendarAppointmentDetails.date.year,
                        calendarAppointmentDetails.date.month,
                        calendarAppointmentDetails.date.day));
                Duration duration2 = DateTime(appointment.endTime.year,
                        appointment.endTime.month, appointment.endTime.day)
                    .difference(DateTime(
                        appointment.endTime.year,
                        appointment.startTime.month,
                        appointment.startTime.day));
                String durationString = '';
                if (duration2.inDays > 0) {
                  durationString =
                      '(${-duration.inDays + 1} / ${duration2.inDays + 1})';
                }
                int? isFinished = (int.tryParse(appointment.notes![0]));
                int? priority = (int.tryParse(appointment.notes![2]));
                if (calendarController.view == CalendarView.day ||
                    calendarController.view == CalendarView.week) {
                  return InkWell(
                    onTap: () async {
                      Appointment appointment =
                          calendarAppointmentDetails.appointments.first;
                      await calendarScheduleController.showWorkDetails(
                          context, appointment, getAllCompleteWork);
                    },
                    child: Container(
                      child: Center(
                        child: Text(
                          appointment.subject,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      color: appointment.color,
                    ),
                  );
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
                                side: BorderSide(color: Colors.white),
                                value: calendarScheduleController.checkBoxMap[
                                        '${appointment.startTime}'] ??
                                    false,
                                onChanged: (value) async {
                                  if (value != null) {
                                    setState(() {
                                      calendarScheduleController.checkBoxMap[
                                          '${appointment.startTime}'] = value;
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
                                width: 180,
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
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                color: COLOR_LEVEL[priority ?? 0],
                                borderRadius: BorderRadius.circular(50)),
                          ),
                          Visibility(
                            visible: isFinished == 1,
                            child: InkWell(
                              child: Icon(FontAwesomeIcons.xmark),
                              onTap: () async {
                                if ((appointment.recurrenceRule?.isNotEmpty ??
                                    false)) {
                                  int result = await showDialog(
                                        context: context,
                                        builder: (context) => DeleteDialog(),
                                      ) ??
                                      0;
                                  if (result == 0) return;
                                  calendarPageController.appointmentList
                                      .remove(appointment);
                                  if (result == 1) {
                                    await calendarScheduleController
                                        .removeWork(appointment.id.toString());
                                    setState(() {
                                      dataSourceController
                                          .removeAppointment(appointment);
                                    });
                                  } else {
                                    await calendarScheduleController
                                        .addExceptionInWork(
                                            appointment.id.toString(),
                                            appointment.startTime);
                                    if (appointment.recurrenceExceptionDates !=
                                        null) {
                                      appointment.recurrenceExceptionDates
                                          ?.add(appointment.startTime);
                                    } else {
                                      appointment.recurrenceExceptionDates = [
                                        appointment.startTime
                                      ];
                                    }
                                    setState(() {
                                      dataSourceController
                                          .updateAppointment(appointment);
                                    });
                                  }
                                } else {
                                  bool result = await showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          content: Text('Xóa công việc này ?'),
                                          actions: [
                                            FilledButton(
                                              onPressed: () {
                                                Navigator.pop(context, true);
                                              },
                                              child: Text('OK'),
                                            ),
                                            FilledButton(
                                              onPressed: () {
                                                Navigator.pop(context, false);
                                              },
                                              child: Text('Hủy'),
                                            )
                                          ],
                                        ),
                                      ) ??
                                      false;
                                  if (result) {
                                    await calendarScheduleController
                                        .removeWork(appointment.id.toString());
                                    setState(() {
                                      dataSourceController
                                          .removeAppointment(appointment);
                                    });
                                  }
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

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
}

class CustomSearchDelegate extends SearchDelegate {
  CalendarDataSource dataSource;
  CalendarScheduleController calendarScheduleController;
  BuildContext context;
  VoidCallback getAllCompleteWork;
  late List<Appointment> appointmentList;
  Future<void> onTap(details) async {
    if ((details.appointments?.length ?? 5) == 1 && details.date != null) {
      Appointment appointment = details.appointments!.first;
      await calendarScheduleController.showWorkDetails(
          context, appointment, getAllCompleteWork);
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, true);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Appointment> matchQuery = [];
    for (var i in appointmentList) {
      if (i.subject.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(i);
      }
    }
    return SfCalendar(
      view: CalendarView.schedule,
      onTap: (calendarTapDetails) async {
        await onTap(calendarTapDetails);
      },
      dataSource: MyCalendarDataSource(matchQuery),
      scheduleViewSettings: ScheduleViewSettings(
          hideEmptyScheduleWeek: true,
          monthHeaderSettings: MonthHeaderSettings(height: 0)),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Appointment> matchQuery = [];
    for (var i in appointmentList) {
      if (i.subject.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(i);
      }
    }
    return SfCalendar(
      view: CalendarView.schedule,
      onTap: onTap,
      dataSource: MyCalendarDataSource(matchQuery),
      scheduleViewSettings: ScheduleViewSettings(
          hideEmptyScheduleWeek: true,
          monthHeaderSettings: MonthHeaderSettings(height: 0)),
    );
  }

  CustomSearchDelegate(this.dataSource, this.calendarScheduleController,
      this.context, this.getAllCompleteWork) {
    appointmentList = dataSource.appointments as List<Appointment>;
  }
}

class TabItem extends StatelessWidget {
  String content;
  TabItem(
    this.content, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        content,
        textAlign: TextAlign.center,
        style: AppTextStyle.h3,
      ),
    );
  }
}

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() {
    return _MyDrawerState();
  }

  MyDrawer(this.calendarController, {super.key});
  CalendarController calendarController;
}

class _MyDrawerState extends State<MyDrawer> {
  ApiServices apiServices = ApiServices();
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  final DateFormat timeFormat = DateFormat("hh:mm a", 'vi_VN');
  bool isWeatherVisible = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
        child: SingleChildScrollView(
            child: Column(children: [
      Container(
        color: widget.calendarController.view == CalendarView.schedule
            ? Colors.lightGreenAccent
            : null,
        child: ListTile(
          leading: Image(
            image: AssetImage('assets/image/schedule_icon.png'),
            width: 25,
            height: 25,
          ),
          style: ListTileStyle.drawer,
          title: Text(
            'Lịch biểu',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {
            widget.calendarController.view = CalendarView.schedule;
            Navigator.pop(context);
          },
        ),
      ),
      DividerWorkItem(),
      Container(
        color: widget.calendarController.view == CalendarView.day
            ? Colors.lightGreenAccent
            : null,
        child: ListTile(
          leading: Image(
            image: AssetImage('assets/image/day_icon.png'),
            width: 25,
            height: 25,
          ),
          style: ListTileStyle.drawer,
          title: Text(
            'Ngày',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {
            widget.calendarController.view = CalendarView.day;
            Navigator.pop(context);
          },
        ),
      ),
      DividerWorkItem(),
      Container(
        color: widget.calendarController.view == CalendarView.week
            ? Colors.lightGreenAccent
            : null,
        child: ListTile(
          leading: Image(
            image: AssetImage('assets/image/week_icon.png'),
            width: 25,
            height: 25,
          ),
          style: ListTileStyle.drawer,
          title: Text(
            'Tuần',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {
            widget.calendarController.view = CalendarView.week;
            Navigator.pop(context);
          },
        ),
      ),
      DividerWorkItem(),
      Container(
        color: widget.calendarController.view == CalendarView.month
            ? Colors.lightGreenAccent
            : null,
        child: ListTile(
          leading: Icon(Icons.grid_on_rounded),
          title: Text(
            'Tháng',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {
            widget.calendarController.view = CalendarView.month;
            Navigator.pop(context);
          },
        ),
      ),
      DividerWorkItem(),
      SizedBox(
        height: 8,
      ),
      Text(
        'Dự báo thời tiết',
        style: AppTextStyle.h2,
      ),
      SizedBox(
        height: 8,
      ),
      FutureBuilder(
        future: apiServices.fetchWeatherData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            WeatherDTO weatherDTO = snapshot.requireData;
            List<ForecastDay> dayList = weatherDTO.forecast.forecastday;
            WeatherLocationDTO location = weatherDTO.location;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ten country
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    RichText(
                        text: TextSpan(
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            children: [
                          TextSpan(text: location.name),
                          TextSpan(text: ','),
                          TextSpan(text: location.country),
                        ])),
                    Spacer(),
                    InkWell(
                      child: Icon(
                          isWeatherVisible
                              ? Icons.cloud_outlined
                              : Icons.cloud_off_outlined,
                          color: lightColorScheme.primary),
                      onTap: () {
                        setState(() {
                          isWeatherVisible = !isWeatherVisible;
                        });
                      },
                    ),
                    SizedBox(
                      width: 4,
                    )
                  ],
                ),
                Visibility(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    ...dayList.map(
                      (e) => Container(
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            //color: Color.fromRGBO(32, 34, 85, 0.7),
                            gradient: LinearGradient(
                              colors: [Color(0xff5bb85f), Color(0xff89f2ff)],
                              stops: [0.1, 1],
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                            )),
                        child: Container(
                          margin: EdgeInsets.all(4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dateFormat.format(e.date),
                                style: TextStyle(fontSize: 18),
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    child: Image(
                                        image: NetworkImage(
                                            e.weatherDay.condition.icon)),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${e.weatherDay.avgtemp_c.toString()} \u00B0C',
                                        style: AppTextStyle.h1.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        e.weatherDay.condition.text,
                                        style: AppTextStyle.h2.copyWith(
                                            color: Colors.deepPurpleAccent),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 4),
                                child: GridView(
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisExtent: 30),
                                  shrinkWrap: true,
                                  children: [
                                    RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: 'Nhiệt độ tối đa: ',
                                            style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                            )),
                                        TextSpan(
                                            text: e.weatherDay.maxtemp_c
                                                    .toString() +
                                                '\u00B0C',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ]),
                                    ),
                                    RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: 'Nhiệt độ tối thiểu: ',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic)),
                                        TextSpan(
                                            text: e.weatherDay.mintemp_c
                                                    .toString() +
                                                '\u00B0C',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ]),
                                    ),
                                    RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: 'Độ ẩm: ',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic)),
                                        TextSpan(
                                          text: e.weatherDay.avghumidity
                                                  .toString() +
                                              '%',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ]),
                                    ),
                                    RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: 'Tầm nhìn: ',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic)),
                                        TextSpan(
                                          text: e.weatherDay.avgvis_km
                                                  .toString() +
                                              ' km',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                    ),
                                    RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: 'Gió tối đa: ',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic)),
                                        TextSpan(
                                          text:
                                              '${e.weatherDay.maxwind_kph.toString()} km/h',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ]),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ]),
                  visible: isWeatherVisible,
                ),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    ])));
  }
}
