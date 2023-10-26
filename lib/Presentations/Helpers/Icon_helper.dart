class WeatherIconHelper {
  static String getWeatherIcon(int weatherCondition, int timezoneOffset) {
    String assetPath;
    DateTime now =
        DateTime.now().toUtc().add(Duration(seconds: timezoneOffset));

    if (now.hour >= 6 && now.hour < 18) {
      switch (weatherCondition) {
        case >= 200 && < 300:
          assetPath = 'assets/weather_icons/day/2.png';
          break;
        case >= 300 && < 400:
          assetPath = 'assets/weather_icons/day/3.png';
          break;
        case >= 500 && < 600:
          assetPath = 'assets/weather_icons/day/5.png';
          break;
        case >= 600 && < 700:
          assetPath = 'assets/weather_icons/day/6.png';
          break;
        case >= 700 && < 800:
          assetPath = 'assets/weather_icons/day/7.png';
          break;
        case == 800:
          assetPath = 'assets/weather_icons/day/8.png';
          break;
        case > 800 && <= 804:
          assetPath = 'assets/weather_icons/day/80.png';
          break;
        default:
          assetPath = 'assets/weather_icons/day/unknown.png';
          break;
      }
    } else {
      switch (weatherCondition) {
        case >= 200 && < 300:
          assetPath = 'assets/weather_icons/night/2.png';
          break;
        case >= 300 && < 400:
          assetPath = 'assets/weather_icons/night/3.png';
          break;
        case >= 500 && < 600:
          assetPath = 'assets/weather_icons/night/5.png';
          break;
        case >= 600 && < 700:
          assetPath = 'assets/weather_icons/night/6.png';
          break;
        case >= 700 && < 800:
          assetPath = 'assets/weather_icons/night/7.png';
          break;
        case == 800:
          assetPath = 'assets/weather_icons/night/8.png';
          break;
        case > 800 && <= 804:
          assetPath = 'assets/weather_icons/night/80.png';
          break;
        default:
          assetPath = 'assets/weather_icons/night/unknown.png';
          break;
      }
    }

    return assetPath;
  }
}
