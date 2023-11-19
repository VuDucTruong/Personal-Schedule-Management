import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_schedule_management/config/calendar_data_source.dart';
import 'package:personal_schedule_management/config/text_styles/app_text_style.dart';
import 'package:personal_schedule_management/config/theme/app_theme.dart';
import 'package:personal_schedule_management/core/data/datasource/remote/api_services.dart';
import 'package:personal_schedule_management/core/data/dto/forecast_weather_dto.dart';
import 'package:personal_schedule_management/core/data/dto/weather_dto.dart';
import 'package:personal_schedule_management/core/data/dto/weather_location_dto.dart';
import 'package:personal_schedule_management/features/controller/calendar_controller.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarDay extends StatelessWidget {
  List<Appointment> data_source;

  CalendarDay(this.data_source, {super.key});

  @override
  Widget build(BuildContext context) {
    ApiServices apiServices = ApiServices();
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    PageController pageController = PageController(viewportFraction: 0.95);
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
                      Consumer<CalendarPageController>(
                        builder: (context, value, child) => InkWell(
                          child: Icon(
                              value.isWeatherVisible
                                  ? Icons.cloud_outlined
                                  : Icons.cloud_off_outlined,
                              color: lightColorScheme.primary),
                          onTap: () {
                            value.changeWeatherVisibility();
                          },
                        ),
                      )
                    ],
                  ),
                  Consumer<CalendarPageController>(
                    builder: (context, controller, child) => Visibility(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                  image: NetworkImage(e
                                                      .weatherDay
                                                      .condition
                                                      .icon)),
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
                                                  style:
                                                      AppTextStyle.h1.copyWith(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  e.weatherDay.condition.text,
                                                  style: AppTextStyle.h2
                                                      .copyWith(
                                                          color: Colors
                                                              .deepPurpleAccent),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 4),
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
                                                        text:
                                                            'Nhiệt độ tối đa: ',
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
                                                                FontWeight
                                                                    .bold)),
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
                                                                FontWeight
                                                                    .bold)),
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
                                                      text: e.weatherDay
                                                              .avgvis_km
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
                      visible: controller.isWeatherVisible,
                    ),
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
          dataSource: GetCalendarDataSource(data_source),
          showTodayButton: true,
          showDatePickerButton: true,
          showNavigationArrow: true,
          showCurrentTimeIndicator: true,
        ),
      ),
    ]));
  }
}
