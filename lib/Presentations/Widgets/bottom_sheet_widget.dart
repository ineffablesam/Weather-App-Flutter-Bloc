import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../Bloc/WeatherBloc/weather_bloc.dart';
import '../Helpers/Icon_helper.dart';
import '../Utils/string_utils.dart';

class BottomSheetWidget extends StatelessWidget {
  final ScrollController scrollController;
  final WeatherBloc weatherBloc;

  const BottomSheetWidget(
      {super.key, required this.weatherBloc, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    String getTodayDay = DateFormat.MMMMd().format(DateTime.now());
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40.r),
        topRight: Radius.circular(40.r),
      ),
      child: SingleChildScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.r),
              topRight: Radius.circular(40.r),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 0.007.sh,
                width: 0.3.sw,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              20.verticalSpace,
              BlocBuilder<WeatherBloc, WeatherState>(
                bloc: weatherBloc,
                builder: (context, state) {
                  return state is WeatherLoading
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.3.sw, vertical: 0.2.sh),
                          child: CupertinoActivityIndicator(
                              color: Colors.grey.shade800))
                      : state is WeatherLoaded
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 10.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade50
                                            .withOpacity(0.1),
                                        blurRadius: 1.r,
                                        spreadRadius: -12.r,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(17.r),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10.w,
                                              vertical: 15.h,
                                            ),
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black26
                                                      .withOpacity(0.1),
                                                  blurRadius: 30.r,
                                                  spreadRadius: -10.r,
                                                ),
                                              ],
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.cloud_outlined,
                                              color: Colors.orange,
                                            ),
                                          ),
                                          10.horizontalSpace,
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Weather',
                                                style: GoogleFonts.outfit(
                                                  fontSize: 16.sp,
                                                  color:
                                                      const Color(0xff19273e),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                'What is the weather like today?',
                                                style: GoogleFonts.outfit(
                                                  fontSize: 12.sp,
                                                  color: const Color(0xff19273e)
                                                      .withOpacity(0.5),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      5.verticalSpace,
                                      Row(
                                        children: [
                                          Expanded(
                                            child: _BuildWeatherMetaContainer(
                                              textColor:
                                                  Colors.deepOrangeAccent,
                                              color: const Color(0xff19273e),
                                              title: 'Pressure',
                                              value:
                                                  '${state.baseWeatherModel.main?.pressure} hPa',
                                            ),
                                          ),
                                          Expanded(
                                            child: _BuildWeatherMetaContainer(
                                              color: const Color(0xffcce16a),
                                              textColor:
                                                  Colors.deepOrangeAccent,
                                              //  textColor: const Color(0xff19273e),
                                              title: 'Humidity',
                                              value:
                                                  '${state.baseWeatherModel.main?.humidity} %',
                                            ),
                                          ),
                                          Expanded(
                                            child: _BuildWeatherMetaContainer(
                                              color: const Color(0xffffffff),
                                              textColor:
                                                  Colors.deepOrangeAccent,
                                              // textColor: const Color(0xff19273e),
                                              title: 'Visibility',
                                              value:
                                                  '${state.baseWeatherModel.visibility} m',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                20.verticalSpace,
                                Text(
                                  'Weather Prediction',
                                  style: GoogleFonts.outfit(
                                    fontSize: 18.sp,
                                    color: const Color(0xff19273e),
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                16.verticalSpace,
                                _BuildWeatherPredictionContainerWidget(
                                    getTimezone:
                                        state.baseWeatherModel.timezone ?? 0,
                                    icon: WeatherIconHelper.getWeatherIcon(
                                      state.baseWeatherModel.weather?.first
                                              .id ??
                                          0,
                                      state.baseWeatherModel.timezone ?? 0,
                                    ),
                                    weatherType: state.baseWeatherModel.weather
                                            ?.first.description ??
                                        '',
                                    minTemp: state
                                            .baseWeatherModel.main?.tempMin
                                            .toString() ??
                                        '',
                                    maxTemp: state
                                        .baseWeatherModel.main!.tempMax
                                        .toString()),
                                15.verticalSpace,
                                Text(
                                  'Wind Information',
                                  style: GoogleFonts.outfit(
                                    fontSize: 18.sp,
                                    color: const Color(0xff19273e),
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                10.verticalSpace,
                                Row(
                                  children: [
                                    Expanded(
                                      child: _BuildWindMetaContainer(
                                        textColor: Colors.black,
                                        title: 'Speed',
                                        value:
                                            '${state.baseWeatherModel.wind?.speed} km/h',
                                      ),
                                    ),
                                    Expanded(
                                      child: _BuildWindMetaContainer(
                                        textColor: Colors.black,
                                        //  textColor: const Color(0xff19273e),
                                        title: 'deg',
                                        value:
                                            '${state.baseWeatherModel.wind?.deg} °',
                                      ),
                                    ),
                                    Expanded(
                                      child: _BuildWindMetaContainer(
                                        textColor: Colors.black,
                                        // textColor: const Color(0xff19273e),
                                        title: 'gust',
                                        value:
                                            '${state.baseWeatherModel.wind?.gust} m/s',
                                      ),
                                    ),
                                  ],
                                ),
                                10.verticalSpace,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Weather Data provided by OpenWeatherMap',
                                          style: GoogleFonts.outfit(
                                            fontSize: 9.sp,
                                            color: const Color(0xff19273e),
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        Text(
                                          'Designed with ❤️ by Samuel',
                                          style: GoogleFonts.outfit(
                                            fontSize: 9.sp,
                                            color: const Color(0xff19273e)
                                                .withOpacity(0.5),
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                40.verticalSpace,
                              ],
                            )
                          : state is WeatherError
                              ? Text(state.message)
                              : const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildWeatherPredictionContainerWidget extends StatelessWidget {
  final String icon, weatherType, minTemp, maxTemp;
  final int getTimezone;
  const _BuildWeatherPredictionContainerWidget({
    required this.getTimezone,
    required this.icon,
    required this.weatherType,
    required this.minTemp,
    required this.maxTemp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 20.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade50.withOpacity(0.1),
            blurRadius: 1.r,
            spreadRadius: -12.r,
          ),
        ],
        borderRadius: BorderRadius.circular(17.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    icon,
                    width: 50.w,
                  ),
                  10.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formatTimezone(getTimezone),
                        style: GoogleFonts.outfit(
                          fontSize: 12.sp,
                          color: const Color(0xff696969),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        weatherType.toTitleCase(),
                        style: GoogleFonts.outfit(
                          fontSize: 17.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              10.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  20.verticalSpace,
                  Text(
                    '$minTemp / $maxTemp°',
                    style: GoogleFonts.outfit(
                      fontSize: 12.sp,
                      color: Colors.deepOrangeAccent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BuildWeatherMetaContainer extends StatelessWidget {
  final Color color, textColor;
  final String title;
  final String value;
  const _BuildWeatherMetaContainer(
      {super.key,
      required this.color,
      required this.title,
      required this.value,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 3.w,
        vertical: 5.h,
      ),
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: Colors.deepOrangeAccent.shade100.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 11.sp,
              color: Colors.black.withOpacity(0.5),
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 14.sp,
              color: textColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildWindMetaContainer extends StatelessWidget {
  final Color textColor;
  final String title;
  final String value;
  const _BuildWindMetaContainer(
      {super.key,
      required this.title,
      required this.value,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 3.w,
        vertical: 5.h,
      ),
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade50.withOpacity(0.1),
            blurRadius: 1.r,
            spreadRadius: -12.r,
          ),
        ],
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 11.sp,
              color: textColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 14.sp,
              color: Colors.deepOrangeAccent,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
