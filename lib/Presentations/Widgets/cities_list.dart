import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Bloc/CitiesCubit/cities_cubit.dart';
import '../../Bloc/WeatherBloc/weather_bloc.dart';
import '../Utils/tap_util.dart';

class CitiesListSelector extends StatefulWidget {
  final WeatherBloc weatherBloc;

  const CitiesListSelector({super.key, required this.weatherBloc});

  @override
  State<CitiesListSelector> createState() => _CitiesListSelectorState();
}

class _CitiesListSelectorState extends State<CitiesListSelector> {
  final TextEditingController _filterController = TextEditingController();
  String filter = '';
  @override
  Widget build(BuildContext context) {
    final citiesCubit = BlocProvider.of<CitiesCubit>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        floatingActionButton: CustomTap(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: CircleAvatar(
            radius: 24.r,
            backgroundColor: Colors.white,
            child: IconButton(
              splashColor: Colors.transparent,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: Colors.transparent,
        body: FadeIn(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40.7, sigmaY: 40.7),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    // physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        99.verticalSpace,
                        Text(
                          'Change Location',
                          style: GoogleFonts.outfit(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: TextField(
                                controller: _filterController,
                                onChanged: (value) {
                                  setState(() {
                                    filter = value;
                                  });
                                },
                                style: GoogleFonts.poppins(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Search for a city',
                                  labelStyle: GoogleFonts.outfit(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.white,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                  suffixIcon: filter.isNotEmpty
                                      ? CustomTap(
                                          onTap: () {
                                            widget.weatherBloc.add(
                                              FetchWeatherByCity(
                                                  _filterController.text
                                                      .trim()),
                                            );
                                            Navigator.of(context).pop();
                                          },
                                          child: const Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                          ),
                                        )
                                      : null,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: BorderSide(
                                      color: Colors.white24,
                                      width: 0.6.w,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 0.6.w,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            BlocBuilder<CitiesCubit,
                                Map<String, List<dynamic>>>(
                              bloc: citiesCubit,
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 0.4.sh,
                                      child: MediaQuery.removePadding(
                                        context: context,
                                        removeTop: true,
                                        child: ListView.builder(
                                          itemCount: state.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            String stateName =
                                                state.keys.elementAt(index);
                                            List cities =
                                                state[stateName] ?? [];

                                            List filteredCities = cities
                                                .where((city) => city
                                                    .toLowerCase()
                                                    .contains(
                                                        filter.toLowerCase()))
                                                .toList();

                                            if (filteredCities.isEmpty) {
                                              return Container();
                                            }

                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ListTile(
                                                  title: Text(
                                                    stateName,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  itemCount:
                                                      filteredCities.length,
                                                  itemBuilder:
                                                      (context, cityIndex) {
                                                    return ListTile(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        widget.weatherBloc.add(
                                                          FetchWeatherByCity(
                                                              filteredCities[
                                                                  cityIndex]),
                                                        );
                                                      },
                                                      title: Text(
                                                        filteredCities[
                                                            cityIndex],
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: Colors
                                                                    .grey
                                                                    .shade300),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            )
                          ],
                        ),
                        99.verticalSpace,
                      ],
                    ),
                  ),
                ),
                IgnorePointer(
                  ignoring: true,
                  child: Container(
                    height: 0.2.sh,
                    decoration: BoxDecoration(
                      // color: Colors.black,
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: FractionalOffset.topCenter,
                        colors: [
                          Colors.black.withOpacity(1),
                          Colors.transparent,
                        ],
                        stops: const [0, 0.30],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }
}
