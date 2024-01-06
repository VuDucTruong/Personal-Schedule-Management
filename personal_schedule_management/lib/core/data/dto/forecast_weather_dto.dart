class WeatherDay {
  dynamic maxtemp_c, mintemp_c, avgtemp_c;
  dynamic maxwind_kph, avgvis_km, avghumidity;
  Condition condition;
  dynamic uv;

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

  @override
  String toString() {
    return 'WeatherDay{maxtemp_c: $maxtemp_c, mintemp_c: $mintemp_c, avgtemp_c: $avgtemp_c, maxwind_kph: $maxwind_kph, avgvis_km: $avgvis_km, avghumidity: $avghumidity, condition: $condition, uv: $uv}';
  }
}

class Forecast {
  late List<ForecastDay> forecastday;

  Forecast(this.forecastday);

  factory Forecast.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonList = json['forecastday'];

    List<ForecastDay> forecastDayList = [];
    for (Map<String, dynamic> i in jsonList) {
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

  @override
  String toString() {
    return 'ForecastDay{date: $date, weatherDay: $weatherDay}';
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

  @override
  String toString() {
    return 'Condition{text: $text, icon: $icon, code: $code}';
  }
}
