import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationServicesDisabled {
  Widget LocationDisabledWidget() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.location_slash, size: 80),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "Location Services disabled\n",
                  style: const TextStyle(
                    fontSize: 30, // Large font size for the hour
                    color: Colors.black,
                    fontFamily: 'Sarabun',
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextSpan(
                  text: 'Turn on Location Services to use the app.',
                  style: const TextStyle(
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
