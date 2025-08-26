import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:testapp/data/models/weather_model.dart';

import '../errors/custom_exceptions.dart';

class ObtainWeather {
  Future<WeatherModel> fetchWeather(double lat, double long) async {
    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast'
      '?latitude=$lat'
      '&longitude=$long'
      '&daily=temperature_2m_min,temperature_2m_max'
      '&hourly=temperature_2m,weather_code,is_day'
      '&current=temperature_2m,is_day,relative_humidity_2m,apparent_temperature,weather_code,rain'
      '&timezone=auto'
      '&forecast_hours=24',
    );

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return WeatherModel.fromJson(data);
      } else {
        throw Exception('Failed to load weather: ${response.statusCode}');
      }
    } catch (e) {
      throw NoInternetException();
    }
  }
}
