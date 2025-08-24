import 'package:testapp/data/models/weather_model.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherModel weather;
  final String imagePath;
  final String cityandCountry;

  WeatherLoaded(this.weather, this.imagePath, this.cityandCountry);
}

class UnknownError extends WeatherState {
  final String message;

  UnknownError(this.message);
}

class LocationDisabledError extends WeatherState {}

class NoInternetError extends WeatherState {}
