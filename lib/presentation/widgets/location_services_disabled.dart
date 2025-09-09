import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationServicesDisabled {
  Widget locationDisabledWidget() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(CupertinoIcons.location_slash, size: 80),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "Location Services disabled\n",
                  style: TextStyle(
                    fontSize: 30, // Large font size for the hour
                    color: Colors.black,
                    fontFamily: 'Sarabun',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'Turn on Location Services to use the app.',
                  style: TextStyle(
                    fontFamily: 'Sarabun',
                    fontWeight: FontWeight.w400,
                    fontSize: 17, // Smaller font size for AM/PM
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
