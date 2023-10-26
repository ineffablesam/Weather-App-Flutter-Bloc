import 'dart:convert';
import 'dart:io' show Platform;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_widget/home_widget.dart';
import 'package:http/http.dart';
import 'package:weather/Data/Models/base_weather_model.dart';

import '../../Data/Repository/weather_repo.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _apiServices;
  WeatherBloc(this._apiServices) : super(WeatherInitial()) {
    on<FetchWeatherByCity>((event, emit) async {
      await _fetchWeatherData(event, emit);
    });
    on<FetchWeatherByLocation>((event, emit) async {
      await _fetchWeatherData(event, emit);
    });
  }

  Future<void> _fetchWeatherData(
      WeatherEvent event, Emitter<WeatherState> emit) async {
    try {
      emit(WeatherLoading());
      if (event is FetchWeatherByCity) {
        final response = await _apiServices.getWeatherDataByCity(event.city);
        await _handleResponse(response, emit);
      } else if (event is FetchWeatherByLocation) {
        final response = await _apiServices.getWeatherDataByLocation();
        await _handleResponse(response, emit);
      }
    } catch (error) {
      emit(WeatherError(message: 'Unable to fetch weather data'));
      debugPrint('_fetchWeatherDataError: $error');
    }
  }

  Future<void> _handleResponse(
      Response response, Emitter<WeatherState> emit) async {
    if (response.statusCode == 200) {
      BaseWeatherModel baseWeatherModel =
          BaseWeatherModel.fromJson(jsonDecode(response.body));
      await updateWeatherWidget(baseWeatherModel.main?.temp.toString() ?? '',
          baseWeatherModel.weather?[0].main ?? '', baseWeatherModel.name ?? '');
      emit(WeatherLoaded(baseWeatherModel: baseWeatherModel));
    } else if (response.statusCode == 404) {
      final data = jsonDecode(response.body);
      emit(WeatherError(message: data['message']));
    } else if (response.statusCode == 429) {
      emit(WeatherError(message: 'Limit crossed'));
    } else {
      emit(WeatherError(message: 'Unknown error ${response.statusCode}'));
    }
  }

  // Function to update the Weather widget in the home page
  String iosWidgetName = 'weather_homescreen';
  Future<void> updateWeatherWidget(String temp, weather, city) async {
    try {
      await HomeWidget.saveWidgetData<String>('temperature', temp);
      await HomeWidget.saveWidgetData<String>('weather', weather);
      await HomeWidget.saveWidgetData<String>('city', city);
      await HomeWidget.updateWidget(iOSName: iosWidgetName);
      debugPrint("📱Weather widget updated successfully in the home screen");
    } catch (e) {
      if (e is PlatformException && Platform.isAndroid) {
        debugPrint(
            "📱Error updating the widget: Android doesn't have a widget for this app");
      } else {
        debugPrint("📱Error updating the widget: $e");
      }
    }
  }
}
