import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../Data/Models/json_cities.dart';

part 'cities_state.dart';

class CitiesCubit extends Cubit<Map<String, List<dynamic>>> {
  CitiesCubit() : super(parseJson());

  static Map<String, List<dynamic>> parseJson() {
    Map<String, dynamic> parsedJson = json.decode(jsonCities);
    return Map<String, List<dynamic>>.from(parsedJson);
  }

  void updateData(Map<String, List<dynamic>> newData) => emit(newData);
}
