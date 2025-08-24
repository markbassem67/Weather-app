
class WeatherModel {
  WeatherModel({
    required this.latitude,
    required this.longitude,
    required this.generationtimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.currentUnits,
    required this.current,
    required this.hourlyUnits,
    required this.hourly,
    required this.dailyUnits,
    required this.daily,
  });

  final double? latitude;
  final double? longitude;
  final double? generationtimeMs;
  final int? utcOffsetSeconds;
  final String? timezone;
  final String? timezoneAbbreviation;
  final double? elevation;
  final CurrentUnits? currentUnits;
  final Current? current;
  final HourlyUnits? hourlyUnits;
  final Hourly? hourly;
  final DailyUnits? dailyUnits;
  final Daily? daily;

  factory WeatherModel.fromJson(Map<String, dynamic> json){
    return WeatherModel(
      latitude: json["latitude"],
      longitude: json["longitude"],
      generationtimeMs: json["generationtime_ms"],
      utcOffsetSeconds: json["utc_offset_seconds"],
      timezone: json["timezone"],
      timezoneAbbreviation: json["timezone_abbreviation"],
      elevation: json["elevation"],
      currentUnits: json["current_units"] == null ? null : CurrentUnits.fromJson(json["current_units"]),
      current: json["current"] == null ? null : Current.fromJson(json["current"]),
      hourlyUnits: json["hourly_units"] == null ? null : HourlyUnits.fromJson(json["hourly_units"]),
      hourly: json["hourly"] == null ? null : Hourly.fromJson(json["hourly"]),
      dailyUnits: json["daily_units"] == null ? null : DailyUnits.fromJson(json["daily_units"]),
      daily: json["daily"] == null ? null : Daily.fromJson(json["daily"]),
    );
  }

}

class Current {
  Current({
    required this.time,
    required this.interval,
    required this.temperature2M,
    required this.isDay,
    required this.relativeHumidity2M,
    required this.apparentTemperature,
    required this.weatherCode
  });

  final String? time;
  final int? interval;
  final double? temperature2M;
  final int? isDay;
  final int? relativeHumidity2M;
  final double? apparentTemperature;
  final int? weatherCode;

  factory Current.fromJson(Map<String, dynamic> json){
    return Current(
      time: json["time"],
      interval: json["interval"],
      temperature2M: json["temperature_2m"],
      isDay: json["is_day"],
      relativeHumidity2M: json["relative_humidity_2m"],
      apparentTemperature: json["apparent_temperature"],
      weatherCode: json['weather_code']
    );
  }

}

class CurrentUnits {
  CurrentUnits({
    required this.time,
    required this.interval,
    required this.temperature2M,
    required this.isDay,
    required this.relativeHumidity2M,
    required this.apparentTemperature,
  });

  final String? time;
  final String? interval;
  final String? temperature2M;
  final String? isDay;
  final String? relativeHumidity2M;
  final String? apparentTemperature;

  factory CurrentUnits.fromJson(Map<String, dynamic> json){
    return CurrentUnits(
      time: json["time"],
      interval: json["interval"],
      temperature2M: json["temperature_2m"],
      isDay: json["is_day"],
      relativeHumidity2M: json["relative_humidity_2m"],
      apparentTemperature: json["apparent_temperature"],
    );
  }

}

class Daily {
  Daily({
    required this.time,
    required this.temperature2MMin,
    required this.temperature2MMax,
  });

  final List<DateTime> time;
  final List<double> temperature2MMin;
  final List<double> temperature2MMax;

  factory Daily.fromJson(Map<String, dynamic> json){
    return Daily(
      time: json["time"] == null ? [] : List<DateTime>.from(json["time"]!.map((x) => DateTime.tryParse(x ?? ""))),
      temperature2MMin: json["temperature_2m_min"] == null ? [] : List<double>.from(json["temperature_2m_min"]!.map((x) => x)),
      temperature2MMax: json["temperature_2m_max"] == null ? [] : List<double>.from(json["temperature_2m_max"]!.map((x) => x)),
    );
  }

}

class DailyUnits {
  DailyUnits({
    required this.time,
    required this.temperature2MMin,
    required this.temperature2MMax,
  });

  final String? time;
  final String? temperature2MMin;
  final String? temperature2MMax;

  factory DailyUnits.fromJson(Map<String, dynamic> json){
    return DailyUnits(
      time: json["time"],
      temperature2MMin: json["temperature_2m_min"],
      temperature2MMax: json["temperature_2m_max"],
    );
  }

}

class Hourly {
  Hourly({
    required this.time,
    required this.temperature2M,
    required this.weatherCode,
    required this.isDay
  });

  final List<String> time;
  final List<double> temperature2M;
  final List<int> weatherCode;
  final List<int> isDay;

  factory Hourly.fromJson(Map<String, dynamic> json){
    return Hourly(
      time: json["time"] == null ? [] : List<String>.from(json["time"]!.map((x) => x)),
      temperature2M: json["temperature_2m"] == null ? [] : List<double>.from(json["temperature_2m"]!.map((x) => x)),
      weatherCode: json["weather_code"] == null ? [] : List<int>.from(json["weather_code"]!.map((x) => x)),
      isDay: json["is_day"] == null ? [] : List<int>.from(json["is_day"]!.map((x) => x)),

    );
  }

}

class HourlyUnits {
  HourlyUnits({
    required this.time,
    required this.temperature2M,
  });

  final String? time;
  final String? temperature2M;

  factory HourlyUnits.fromJson(Map<String, dynamic> json){
    return HourlyUnits(
      time: json["time"],
      temperature2M: json["temperature_2m"],
    );
  }

}
