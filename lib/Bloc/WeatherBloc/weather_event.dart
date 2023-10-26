part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchWeatherByCity extends WeatherEvent {
  final String city;

  const FetchWeatherByCity(this.city);

  @override
  List<Object> get props => [city];
}

class FetchWeatherByLocation extends WeatherEvent {
  const FetchWeatherByLocation();

  @override
  List<Object> get props => [];
}
