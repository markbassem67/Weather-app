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
    return Container(
      width: 130,
      height: 110,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.fromLTRB(6, 4, 0, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade200,
          // border color
          width: 2.0, // border width
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                weatherIcon,
                size: 19,
                color: isDay == 1
                    ? const Color(0xFF87CEEB)
                    : const Color(0xFF472B97),
              ),
              Text(parameterType, style: const TextStyle(fontSize: 16)),
            ],
          ),
          Text(
            weatherIcon == CupertinoIcons.drop ||
                    weatherIcon == CupertinoIcons.cloud_sun
                ? '$parameterValue%'
                : parameterValue.toString(),
            style: const TextStyle(fontSize: 31),
          ),
          Text(
            severityCalc(parameterValue),
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
