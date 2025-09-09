import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherContainer {
  Widget weatherContainer(
    IconData weatherIcon,
    int isDay,
    String parameterType,
    int parameterValue,
    String Function(int) severityCalc,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        // ✅ Make sure 3 containers fit within one row
        final containerWidth = (screenWidth / 3) - 16; // subtract spacing
        final containerHeight = screenHeight * 0.12;

        return Container(
          width: containerWidth,
          height: containerHeight,
          margin: const EdgeInsets.all(5),
          padding: EdgeInsets.fromLTRB(
            screenWidth * 0.02,
            screenHeight * 0.005,
            0,
            0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200, width: 2.0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    weatherIcon,
                    size: containerWidth * 0.15, // scale with container size
                    color: isDay == 1
                        ? const Color(0xFF87CEEB)
                        : const Color(0xFF472B97),
                  ),
                  Flexible(
                    child: Text(
                      ' $parameterType',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: containerWidth * 0.12),
                    ),
                  ),
                ],
              ),
              Text(
                weatherIcon == CupertinoIcons.drop ||
                        weatherIcon == CupertinoIcons.cloud_sun
                    ? '$parameterValue%'
                    : parameterValue.toString(),
                style: TextStyle(fontSize: containerWidth * 0.25),
              ),
              Text(
                severityCalc(parameterValue),
                style: TextStyle(fontSize: containerWidth * 0.1),
              ),
            ],
          ),
        );
      },
    );
  }
}
