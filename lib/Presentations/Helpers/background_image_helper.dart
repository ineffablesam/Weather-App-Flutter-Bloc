class BackgroundImageHelper {
  static String getBackgroundImage(int? timezoneOffset) {
    DateTime now =
        DateTime.now().toUtc().add(Duration(seconds: timezoneOffset!));

    if (now.hour >= 6 && now.hour < 8) {
      return 'assets/images/early_morning.jpg';
    } else if (now.hour >= 8 && now.hour < 18) {
      return 'assets/images/daytime.jpeg';
    } else if (now.hour >= 18 && now.hour < 20) {
      return 'assets/images/sunset.jpg';
    } else {
      return 'assets/images/nighttime_2.jpg';
    }
  }
}
