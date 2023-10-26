part of 'weather_bloc.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final BaseWeatherModel baseWeatherModel;
  WeatherLoaded({required this.baseWeatherModel});

  List<Object> get props => [baseWeatherModel];
}

class WeatherError extends WeatherState {
  final String message;
  WeatherError({required this.message});

  List<Object> get props => [message];
}
