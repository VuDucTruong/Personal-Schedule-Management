import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../dto/weather_dto.dart';

class ApiServices {
  static const String baseURL = 'http://api.weatherapi.com/v1';

  Future<WeatherDTO> fetchWeatherData() async {
    Response response = await http.get(Uri.parse(
        '$baseURL/forecast.json?key=d9ae32330a674b9f9d1135156232109&q=auto:ip&days=3&lang=vi'));
    Position? position = await _determinePosition();
    if (position != null) {
      response = await http.get(Uri.parse(
          '$baseURL/forecast.json?key=d9ae32330a674b9f9d1135156232109&q=${position.latitude},${position.longitude}&days=3&lang=vi'));
    }
    print(response.request);
    if (response.statusCode == 200) {
      final data = utf8.decode(response.bodyBytes);
      return WeatherDTO.fromJson(jsonDecode(data));
    } else {
      throw Exception('Fatal error');
    }
  }

  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }
    Position? position;
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low,
          timeLimit: Duration(seconds: 2));
    } catch (e) {
      return null;
    }

    return position;
  }
}
