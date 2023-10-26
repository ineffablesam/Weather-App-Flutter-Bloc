import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'temperatureunit_event.dart';
part 'temperatureunit_state.dart';

class TemperatureUnitBloc
    extends Bloc<TemperatureUnitToggleEvent, TemperatureUnitState> {
  TemperatureUnitBloc() : super(TemperatureUnitCelsius()) {
    on<TemperatureUnitToggleEvent>((event, emit) {
      if (state is TemperatureUnitCelsius) {
        emit(TemperatureUnitFahrenheit());
        debugPrint('Temperature is Fahrenheit');
      } else {
        debugPrint('Temperature is Celsius');
        emit(TemperatureUnitCelsius());
      }
    });
  }

  @override
  Stream<TemperatureUnitState> mapEventToState(
      TemperatureUnitToggleEvent event) async* {
    if (state is TemperatureUnitCelsius) {
      yield TemperatureUnitFahrenheit();
    } else {
      yield TemperatureUnitCelsius();
    }
  }
}
