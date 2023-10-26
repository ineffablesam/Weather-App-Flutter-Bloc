import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/Presentations/Utils/tap_util.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      body: Column(
        children: [
          SizedBox(
            height: 0.5.sh,
            child: Image.asset(
              'assets/images/welcome.jpg',
              fit: BoxFit.cover,
            ),
          ),
          30.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/splash-logo.png',
                      height: 0.1.sh,
                    ),
                    10.horizontalSpace,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to Weather App',
                          style: GoogleFonts.outfit(
                            fontSize: 17.sp,
                            color: Colors.blueGrey.shade900,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'A Place to get all your weather details',
                          style: GoogleFonts.splineSans(
                            fontSize: 10.sp,
                            color: Colors.blueGrey.shade500,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                20.verticalSpace,
                const _BuildFeaturesTitle(
                  title: 'Change the Location to get the weather details',
                ),
                const _BuildFeaturesTitle(
                  title: 'Get the weather details of the next 7 days',
                ),
                const _BuildFeaturesTitle(
                  title: 'Schedule your day with the weather details',
                ),
                const _BuildFeaturesTitle(
                  title: 'Get Air Quality Index of your location',
                ),
                10.verticalSpace,
                CustomTap(
                  onTap: () {
                    _determinePosition().then((value) {
                      // clear the previous route and push the new route
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/home', (route) => false,
                          arguments: value);
                    });
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent.shade200,
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                          child: Center(
                            child: Text(
                              'Get Started',
                              style: GoogleFonts.splineSans(
                                fontSize: 15.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition();
}

class _BuildFeaturesTitle extends StatelessWidget {
  final String title;
  const _BuildFeaturesTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 3.r,
            backgroundColor: Colors.blue.shade900,
          ),
          10.horizontalSpace,
          SizedBox(
            width: 0.83.sw,
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.clip,
              style: GoogleFonts.splineSans(
                fontSize: 13.sp,
                color: Colors.blueGrey.shade500,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
