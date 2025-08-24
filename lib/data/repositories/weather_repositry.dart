import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:testapp/core/network/weather_api_service.dart';
import 'package:testapp/data/models/weather_model.dart';

import '../../core/errors/custom_exceptions.dart';
import '../../core/services/location_services.dart';
import '../../core/services/reverse_geocoding_service.dart';

class WeatherRepository {
  final ObtainWeather service;
  final LocationServices locationService;
  final ReverseGeocodingService reversegeocode;

  WeatherRepository(this.service, this.locationService, this.reversegeocode);

  Future<WeatherModel> fetchWeather() async {
    try {
      // 1. Check location
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw LocationDisabledException();
      }

      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw LocationDisabledException();
      }

      final position = await locationService.determinePosition();
      return service.fetchWeather(position.latitude, position.longitude);
    } on SocketException {
      throw NoInternetException();
    } on LocationDisabledException {
      rethrow;
    } catch (e) {
      throw UnknownWeatherException(e.toString());
    }
  }

  Future<String> getCityAndCountry(double lat, double lon) async {
    return await reversegeocode.getCityAndCountry(lat, lon);
  }
}
