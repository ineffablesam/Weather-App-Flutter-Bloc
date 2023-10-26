import 'package:intl/intl.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

String formatTimezone(int timezoneOffset) {
  DateTime dateTime = DateTime.now().add(Duration(seconds: timezoneOffset));
  String formattedDateTime = DateFormat("MMMM d | HH:mm").format(dateTime);
  return formattedDateTime;
}

double celsiusToFahrenheit(double celsius) {
  return (celsius * 9 / 5) + 32;
}
