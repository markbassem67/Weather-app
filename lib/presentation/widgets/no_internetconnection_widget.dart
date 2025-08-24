import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoInternetWidget {
  Widget noConnection() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.wifi_exclamationmark, size: 80),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "No Internet Connection\n",
                  style: const TextStyle(
                    fontSize: 30, // Large font size for the hour
                    color: Colors.black,
                    fontFamily: 'Sarabun',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: 'Check your connection and try again.',
                  style: const TextStyle(
                    fontFamily: 'Sarabun',
                    fontWeight: FontWeight.w400,
                    fontSize: 15, // Smaller font size for AM/PM
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
