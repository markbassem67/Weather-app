import 'package:flutter/cupertino.dart';

class DaysForecast {
  List<String> getCurrentWeekDays() {
    DateTime now = DateTime.now();

    List<String> weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    return List.generate(7, (i) {
      final index = (now.weekday - 1 + i) % 7;
      return weekdays[index];
    });
  }

  Widget daysForecastWidget(List<double> maxTemp, List<double> minTemp) {
    List<String> days = getCurrentWeekDays();
    return Center(
      child: Container(
        width: 300,
        child: Column(
          children: List.generate(7, (index) {
            final isSmallFont = index == 0;
            final fontSize = isSmallFont ? 17.0 : 19.0;
            return Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Text(
                      index == 0 ? 'Today' : days[index],
                      style: TextStyle(
                        color: const Color(0xFF474747),
                        fontSize: fontSize,
                        fontFamily: 'Sarabun',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 18, height: 18),
                      const SizedBox(width: 18, height: 18),
                      SizedBox(
                        child: Text(
                          '${minTemp[index].round().toString()}°',
                          style: TextStyle(
                            color: const Color(0xFF474747),
                            fontSize: fontSize,
                            fontFamily: 'Sarabun',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 28,
                        child: Text(
                          '${maxTemp[index].round().toString()}°',
                          style: TextStyle(
                            color: const Color(0xFF474747),
                            fontSize: fontSize,
                            fontFamily: 'Sarabun',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

}
