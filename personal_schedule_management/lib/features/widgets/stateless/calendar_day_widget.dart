import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_schedule_management/config/calendar_data_source.dart';
import 'package:personal_schedule_management/config/text_styles/app_text_style.dart';
import 'package:personal_schedule_management/config/theme/app_theme.dart';
import 'package:personal_schedule_management/core/data/datasource/remote/api_services.dart';
import 'package:personal_schedule_management/core/data/dto/forecast_weather_dto.dart';
import 'package:personal_schedule_management/core/data/dto/weather_dto.dart';
import 'package:personal_schedule_management/core/data/dto/weather_location_dto.dart';
import 'package:personal_schedule_management/features/controller/calendar_schedule_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarDay extends StatefulWidget {
  CalendarDay(this.dataSource, this.setStateCallback, {super.key});
  MyCalendarDataSource dataSource;
  VoidCallback setStateCallback;
  @override
  State<CalendarDay> createState() => _CalendarDayState();
}

class _CalendarDayState extends State<CalendarDay> {
  ApiServices apiServices = ApiServices();
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  final DateFormat timeFormat = DateFormat("hh:mm a", 'vi_VN');
  PageController pageController = PageController(viewportFraction: 0.95);
  bool isWeatherVisible = true;
  CalendarScheduleController calendarScheduleController =
      CalendarScheduleController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Column(children: [
      FutureBuilder(
        future: apiServices.fetchWeatherData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            WeatherDTO weatherDTO = snapshot.requireData;
            List<ForecastDay> dayList = weatherDTO.forecast.forecastday;
            WeatherLocationDTO location = weatherDTO.location;
            bool isVisible = true;
            return Container(
              margin: EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                  fontStyle: FontStyle.italic),
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
                    ],
                  ),
                  Visibility(
                    child: Container(
                      height: 185,
                      child: PageView(
                          controller: pageController,
                          scrollDirection: Axis.horizontal,
                          children: [
                            ...dayList.map(
                              (e) => Container(
                                margin: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    //color: Color.fromRGBO(32, 34, 85, 0.7),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xff5bb85f),
                                        Color(0xff89f2ff)
                                      ],
                                      stops: [0.1, 1],
                                      begin: Alignment.bottomRight,
                                      end: Alignment.topLeft,
                                    )),
                                child: Container(
                                  margin: EdgeInsets.all(4),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                image: NetworkImage(e.weatherDay
                                                    .condition.icon)),
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
                                                    color: Colors
                                                        .deepPurpleAccent),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin:
                                              EdgeInsets.symmetric(vertical: 4),
                                          child: GridView(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    mainAxisExtent: 25),
                                            shrinkWrap: true,
                                            children: [
                                              RichText(
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text: 'Nhiệt độ tối đa: ',
                                                      style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                      )),
                                                  TextSpan(
                                                      text: e.weatherDay
                                                              .maxtemp_c
                                                              .toString() +
                                                          '\u00B0C',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ]),
                                              ),
                                              RichText(
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text:
                                                          'Nhiệt độ tối thiểu: ',
                                                      style: TextStyle(
                                                          fontStyle: FontStyle
                                                              .italic)),
                                                  TextSpan(
                                                      text: e.weatherDay
                                                              .mintemp_c
                                                              .toString() +
                                                          '\u00B0C',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ]),
                                              ),
                                              RichText(
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text: 'Độ ẩm: ',
                                                      style: TextStyle(
                                                          fontStyle: FontStyle
                                                              .italic)),
                                                  TextSpan(
                                                    text: e.weatherDay
                                                            .avghumidity
                                                            .toString() +
                                                        '%',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ]),
                                              ),
                                              RichText(
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text: 'Tầm nhìn: ',
                                                      style: TextStyle(
                                                          fontStyle: FontStyle
                                                              .italic)),
                                                  TextSpan(
                                                    text: e.weatherDay.avgvis_km
                                                            .toString() +
                                                        ' km',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ]),
                                              ),
                                              RichText(
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text: 'Gió tối đa: ',
                                                      style: TextStyle(
                                                          fontStyle: FontStyle
                                                              .italic)),
                                                  TextSpan(
                                                    text:
                                                        '${e.weatherDay.maxwind_kph.toString()} km/h',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ]),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ]),
                    ),
                    visible: isWeatherVisible,
                  ),
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      Expanded(
        child: SfCalendar(
          view: CalendarView.day,
          dataSource: widget.dataSource,
          showTodayButton: true,
          showDatePickerButton: true,
          showNavigationArrow: true,
          showCurrentTimeIndicator: true,
          onTap: (details) async {
            //calendarScheduleController.showWorkDetails(context, details.)
            if ((details.appointments?.length ?? 5) == 1 &&
                details.date != null) {
              Appointment appointment = details.appointments!.first;
              await calendarScheduleController.showWorkDetails(
                  context, appointment, () => widget.setStateCallback());
            }
          },
        ),
      ),
    ]));
  }
}
