class WeatherDay {
  double maxtemp_c, mintemp_c, avgtemp_c;
  double maxwind_kph, avgvis_km, avghumidity;
  Condition condition;
  double uv;

  WeatherDay(this.maxtemp_c, this.mintemp_c, this.avgtemp_c, this.maxwind_kph,
      this.avgvis_km, this.avghumidity, this.condition, this.uv);

  factory WeatherDay.fromJson(Map<String, dynamic> json) {
    return WeatherDay(
        json['maxtemp_c'],
        json['mintemp_c'],
        json['avgtemp_c'],
        json['maxwind_kph'],
        json['avgvis_km'],
        json['avghumidity'],
        Condition.fromJson(json['condition']),
        json['uv']);
  }
}

class Forecast {
  late List<ForecastDay> forecastday;

  Forecast(this.forecastday);

  factory Forecast.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonList = json['forecastday'];
    List<ForecastDay> forecastDayList = [];
    for (dynamic i in jsonList) {
      forecastDayList.add(ForecastDay.fromJson(i));
    }
    return Forecast(forecastDayList);
  }

  @override
  String toString() {
    return 'Forecast{forecastday: $forecastday}';
  }
}

class ForecastDay {
  late DateTime date;
  late WeatherDay weatherDay;

  ForecastDay(this.date, this.weatherDay);

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    return ForecastDay(
        DateTime.parse(json['date']), WeatherDay.fromJson(json['day']));
  }
}

class Condition {
  String text;
  String icon;
  int code;

  Condition(this.text, this.icon, this.code);

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(json['text'], 'https:' + json['icon'], json['code']);
  }
}
