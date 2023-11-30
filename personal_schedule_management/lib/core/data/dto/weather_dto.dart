import 'package:personal_schedule_management/core/data/dto/forecast_weather_dto.dart';
import 'package:personal_schedule_management/core/data/dto/weather_location_dto.dart';

class WeatherDTO {
  WeatherLocationDTO location;
  Forecast forecast;

  WeatherDTO(this.location, this.forecast);

  factory WeatherDTO.fromJson(Map<String, dynamic> json) {
    return WeatherDTO(WeatherLocationDTO.fromJson(json['location']),
        Forecast.fromJson(json['forecast']));
  }
}
