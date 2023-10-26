import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/Presentations/Utils/string_utils.dart';

import '../../Bloc/TemperatureUnitsBloc/temperatureunit_bloc.dart';

class TemperatureWidget extends StatelessWidget {
  final String apitemperature, weatherType;

  const TemperatureWidget(
      {super.key, required this.apitemperature, required this.weatherType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<TemperatureUnitBloc, TemperatureUnitState>(
          builder: (context, unitState) {
            final isFahrenheit = unitState is TemperatureUnitFahrenheit;
            final temperature = isFahrenheit
                ? celsiusToFahrenheit(double.parse(apitemperature))
                    .toStringAsFixed(2)
                : apitemperature;
            return Text(
              '$temperature ${isFahrenheit ? '°F' : '°C'}',
              style: GoogleFonts.outfit(
                shadows: [
                  Shadow(
                    color: Colors.black26,
                    blurRadius: 30.r,
                    offset: const Offset(0, 0),
                  ),
                ],
                fontSize: 70.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        Text(
          weatherType.toUpperCase(),
          maxLines: 1,
          style: GoogleFonts.splineSans(
            shadows: [
              Shadow(
                color: Colors.black26,
                blurRadius: 30.r,
                offset: const Offset(0, 0),
              ),
            ],
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
