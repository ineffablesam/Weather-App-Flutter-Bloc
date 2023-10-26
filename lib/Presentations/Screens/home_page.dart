import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:weather/Bloc/InternetBloc/internet_bloc.dart';
import 'package:weather/Bloc/WeatherBloc/weather_bloc.dart';
import 'package:weather/Data/Repository/weather_repo.dart';
import 'package:weather/Presentations/Helpers/custom_dialog.dart';
import 'package:weather/Presentations/Utils/tap_util.dart';
import 'package:weather/Presentations/Widgets/cities_list.dart';
import 'package:weather/Presentations/Widgets/temperature_widget.dart';

import '../CustomComponents/custom_slidingup_panel.dart';
import '../Helpers/background_image_helper.dart';
import '../Widgets/bottom_sheet_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherBloc weatherBloc = WeatherBloc(WeatherRepository());
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 20.r,
          onPressed: () {
            HapticFeedback.selectionClick();
            weatherBloc.add(const FetchWeatherByLocation());
          },
          icon: const Icon(
            Icons.refresh_rounded,
            color: Colors.white,
          ),
        ),
        title: BlocBuilder<WeatherBloc, WeatherState>(
          bloc: weatherBloc..add(const FetchWeatherByLocation()),
          builder: (context, state) {
            return state is WeatherLoading
                ? const CupertinoActivityIndicator(color: Colors.white)
                : state is WeatherLoaded
                    ? Column(
                        children: [
                          Text(
                            state.baseWeatherModel.name.toString(),
                            style: GoogleFonts.outfit(
                              fontSize: 20.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            (state is FetchWeatherByLocation)
                                ? 'Today'
                                : state.baseWeatherModel.sys?.country
                                        ?.toString() ??
                                    '',
                            style: GoogleFonts.outfit(
                              fontSize: 17.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )
                    : state is WeatherError
                        ? Text(state.message)
                        : const SizedBox.shrink();
          },
        ),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        actions: [
          IconButton(
            splashRadius: 20.r,
            onPressed: () {
              context.pushTransparentRoute(
                CitiesListSelector(
                  weatherBloc: weatherBloc,
                ),
              );
              HapticFeedback.selectionClick();
            },
            icon: const Icon(
              Icons.location_on,
              color: Colors.white,
            ),
          ),
          CustomTap(
            onTap: () {
              HapticFeedback.selectionClick();
              Navigator.pushNamed(context, '/account');
            },
            child: Hero(
              tag: 'profile',
              child: CircleAvatar(
                radius: 20.r,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 18.r,
                  backgroundColor: Colors.transparent,
                  backgroundImage: const AssetImage(
                    'assets/images/profile.jpg',
                  ),
                ),
              ),
            ),
          ),
          10.horizontalSpace,
        ],
        backgroundColor: Colors.transparent,
      ),
      body: BlocListener<InternetBloc, InternetState>(
        listener: (context, state) {
          if (state is InternetConnected) {
            weatherBloc.add(const FetchWeatherByLocation());
            debugPrint('Internet Connected');
            // Navigator.of(context).pop();
          } else if (state is InternetDisconnected) {
            debugPrint('Internet Disconnected');
            DialogHelper.showInternetDisconnectedDialog(context);
          }
        },
        child: SlidingUpPanel(
          maxHeight: 520.h,
          minHeight: 330.h,
          color: const Color(0xfff7f7f7),
          backdropTapClosesPanel: true,
          backdropEnabled: true,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.r),
            topRight: Radius.circular(40.r),
          ),
          controller: PanelController(),
          parallaxOffset: 0.5,
          parallaxEnabled: true,
          isDraggable: true,
          panelBuilder: (
            ScrollController sc,
          ) =>
              BottomSheetWidget(
            scrollController: sc,
            weatherBloc: weatherBloc,
          ),
          body: BlocBuilder<WeatherBloc, WeatherState>(
            bloc: weatherBloc,
            builder: (context, state) {
              return state is WeatherLoading
                  ? Shimmer(
                      color: Colors.grey.shade800,
                      child: Container(
                        color: Colors.grey.shade300,
                      ),
                    )
                  : state is WeatherLoaded
                      ? Stack(
                          fit: StackFit.expand,
                          alignment: Alignment.topCenter,
                          children: [
                            Image.asset(
                              BackgroundImageHelper.getBackgroundImage(
                                  state.baseWeatherModel.timezone),
                              fit: BoxFit.cover,
                              height: double.infinity,
                              alignment: Alignment.center,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TemperatureWidget(
                                  apitemperature: state
                                          .baseWeatherModel.main?.temp
                                          .toString() ??
                                      "",
                                  weatherType: state.baseWeatherModel.weather!
                                          .first.main ??
                                      "",
                                ),
                                0.2.sh.verticalSpace,
                              ],
                            ),
                          ],
                        )
                      : state is WeatherError
                          ? Center(
                              child: Text(
                                state.message,
                                style: GoogleFonts.outfit(
                                  fontSize: 20.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
