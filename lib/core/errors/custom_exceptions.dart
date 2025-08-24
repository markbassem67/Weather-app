class LocationDisabledException implements Exception {}

class NoInternetException implements Exception {}

class UnknownWeatherException implements Exception {
  final String message;

  UnknownWeatherException([this.message = "Unknown error occurred"]);
}
