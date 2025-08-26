import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class WeatherTimeline {
  final List<String> times;
  final List<String> temps;
  final String description;
  final List<int> weatherCode;
  final List<int> isDay;

  WeatherTimeline({
    required this.times,
    required this.temps,
    required this.description,
    required this.weatherCode,
    required this.isDay,
  });

  List<String> getFormattedTimes(String pattern) {
    List<String> formattedTimes = [];
    DateTime now = DateTime.now();

    for (int i = 0; i < 24; i++) {
      DateTime futureTime = now.add(Duration(hours: i));
      String formattedTime = DateFormat(pattern).format(futureTime);
      formattedTimes.add(formattedTime);
    }
    return formattedTimes;
  }

  List<IconData> getWeatherIcon(List<int> weatherCode, List<int> isDay) {
    List<IconData> weatherIcons = [];
    for (int i = 0; i < weatherCode.length; i++) {
      if ((weatherCode[i] == 0 && isDay[i] == 1) ||
          (weatherCode[i] == 1 && isDay[i] == 1)) {
        weatherIcons.add(CupertinoIcons.sun_min);
      } else if ((weatherCode[i] == 0 && isDay[i] == 0) ||
          (weatherCode[i] == 1 && isDay[i] == 0)) {
        weatherIcons.add(CupertinoIcons.moon_stars);
      } else if ((weatherCode[i] == 2 && isDay[i] == 1) ||
          (weatherCode[i] == 3 && isDay[i] == 1)) {
        weatherIcons.add(CupertinoIcons.cloud_sun);
      } else if ((weatherCode[i] == 2 && isDay[i] == 0) ||
          (weatherCode[i] == 3 && isDay[i] == 0)) {
        weatherIcons.add(CupertinoIcons.cloud_moon);
      } else if (weatherCode[i] == 45 || weatherCode[i] == 48) {
        weatherIcons.add(CupertinoIcons.cloud_fog);
      } else if (weatherCode[i] == 51 ||
          weatherCode[i] == 53 ||
          weatherCode[i] == 55) {
        weatherIcons.add(CupertinoIcons.cloud_drizzle); // Drizzle
      } else if (weatherCode[i] == 56 || weatherCode[i] == 57) {
        weatherIcons.add(CupertinoIcons.cloud_drizzle_fill); // Freezing Drizzle
      } else if (weatherCode[i] == 61 ||
          weatherCode[i] == 63 ||
          weatherCode[i] == 65) {
        weatherIcons.add(CupertinoIcons.cloud_rain); // Rain
      } else if (weatherCode[i] == 66 || weatherCode[i] == 67) {
        weatherIcons.add(CupertinoIcons.cloud_heavyrain); // Freezing Rain
      } else if (weatherCode[i] == 71 ||
          weatherCode[i] == 73 ||
          weatherCode[i] == 75 ||
          weatherCode[i] == 77) {
        weatherIcons.add(CupertinoIcons.snow); // Snow fall and snow grains
      } else if (weatherCode[i] == 80 ||
          weatherCode[i] == 81 ||
          weatherCode[i] == 82) {
        weatherIcons.add(CupertinoIcons.cloud_rain_fill); // Rain showers
      } else if (weatherCode[i] == 85 || weatherCode[i] == 86) {
        weatherIcons.add(CupertinoIcons.cloud_snow); // Snow showers
      } else if (weatherCode[i] == 95 ||
          weatherCode[i] == 96 ||
          weatherCode[i] == 99) {
        weatherIcons.add(CupertinoIcons.cloud_bolt_rain); // Thunderstorm
      } else {
        weatherIcons.add(CupertinoIcons.sun_min);
      }
    }
    return weatherIcons;
  }

  Widget buildWidget() {
    const double startLeft = 13;
    const double timeTop = 17;
    const double tempTop = 64;
    const double gap = 43;
    const Color textColor = Color(0xFF474747);
    List<String> times = getFormattedTimes('h');
    times[0] = 'Now';
    List<String> meridian = getFormattedTimes('a');
    meridian[0] = '';
    List<IconData> weatherIcons = getWeatherIcon(weatherCode, isDay);
    // Dynamic width: base padding + spacing for each item
    double totalWidth = startLeft + (gap * (times.length - 1)) + 60;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(width: 8),
            Text(
              description,
              style: const TextStyle(
                color: textColor,
                fontSize: 18,
                fontFamily: 'Sarabun',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),

        Container(
          height: 90,
          //mmkn a8yro b3den l lazy scrolling ya marko listview.builder
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: totalWidth,
              child: Stack(
                children: [
                  for (int i = 0; i < times.length; i++)
                    Positioned(
                      left: startLeft + (gap * i),
                      top: timeTop,
                      child: SizedBox(
                        width: 38,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: times[i],
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: textColor,
                                  fontFamily: 'Sarabun',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: meridian[i],
                                style: const TextStyle(
                                  fontFamily: 'Sarabun',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11, // Smaller font size for AM/PM
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  for (int i = 0; i < temps.length; i++)
                    Positioned(
                      left: (startLeft + 5) + (gap * i),
                      top: tempTop,
                      child: SizedBox(
                        width: 29,
                        child: Text(
                          '${temps[i]}°',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: textColor,
                            fontSize: 15,
                            fontFamily: 'Sarabun',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),

                  // Divider line
                  Positioned(
                    left: 0,
                    top: 10,
                    child: Container(
                      width: totalWidth,
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0x33C3C3C3),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Icon placeholders
                  for (int i = 0; i < times.length; i++)
                    Positioned(
                      left: 16 + (gap * i),
                      top: 37,
                      child: Container(
                        width: 30,
                        height: 30,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(),
                        child: Icon(weatherIcons[i], color: const Color(0xFF474747)),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
