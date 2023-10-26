part of 'temperatureunit_bloc.dart';

enum TemperatureUnit { celsius, fahrenheit }

abstract class TemperatureUnitState {}

class TemperatureUnitCelsius extends TemperatureUnitState {}

class TemperatureUnitFahrenheit extends TemperatureUnitState {}
