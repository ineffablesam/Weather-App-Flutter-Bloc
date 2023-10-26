import 'package:flutter/material.dart';

class DayNightColoHelper {
  /// The Gradient Helper is not used current in the app
  /// It is used to generate the background gradient based on the time of day
  static LinearGradient getBackgroundGradient(int? timezoneOffset) {
    DateTime now =
        DateTime.now().toUtc().add(Duration(seconds: timezoneOffset!));

    if (now.hour >= 6 && now.hour < 8) {
      // Early morning gradient
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.blue,
          Colors.orange.shade50,
          Colors.white,
        ],
      );
    } else if (now.hour >= 8 && now.hour < 18) {
      // Daytime gradient
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xff65d3ef),
          Color(0xffb0f3fd),
          Color(0xffa4ef85),
          Color(0xff75cd89),
        ],
      );
    } else if (now.hour >= 18 && now.hour < 20) {
      // Sunset gradient
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xff1c2bc3),
          Color(0xff4b47c3),
          Color(0xffcda2a1),
          Color(0xfff7eedb),
        ],
      );
    } else {
      // Nighttime gradient
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.indigo,
          Colors.black,
        ],
      );
    }
  }

  static Color getTextColor(int? timezoneOffset) {
    DateTime now =
        DateTime.now().toUtc().add(Duration(seconds: timezoneOffset!));

    if (now.hour >= 6 && now.hour < 18) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }
}
