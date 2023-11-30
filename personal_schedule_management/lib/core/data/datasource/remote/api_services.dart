import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../dto/weather_dto.dart';

class ApiServices {
  static const String baseURL = 'http://api.weatherapi.com/v1';

  Future<WeatherDTO> fetchWeatherData() async {
    final response = await http.get(Uri.parse(baseURL +
        '/forecast.json?key=d9ae32330a674b9f9d1135156232109&q=auto:ip&days=3&lang=vi'));
    if (response.statusCode == 200) {
      final data = utf8.decode(response.bodyBytes);
      return WeatherDTO.fromJson(jsonDecode(data));
    } else {
      throw Exception('Fatal error');
    }
  }
}
