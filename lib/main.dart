import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_widget/home_widget.dart';
import 'package:weather/Bloc/InternetBloc/internet_bloc.dart';
import 'package:weather/Bloc/TemperatureUnitsBloc/temperatureunit_bloc.dart';
import 'package:weather/Data/Repository/weather_repo.dart';
import 'package:weather/Services/notification_service.dart';

import 'Bloc/CitiesCubit/cities_cubit.dart';
import 'Bloc/WeatherBloc/weather_bloc.dart';
import 'Presentations/Routes/route_generator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HomeWidget.setAppGroupId(appGroupId);
  NotificationService.initializeAwesomeNotifications();
  runApp(const MyApp());
}

String appGroupId = 'group.weather_app_group';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Weather Bloc
        BlocProvider(
          create: (context) => WeatherBloc(
            RepositoryProvider.of<WeatherRepository>(context),
          ),
        ),
        // Internet Bloc
        BlocProvider(
          create: (context) => InternetBloc(),
        ),
        //Cities Cubit
        BlocProvider(
          create: (context) => CitiesCubit(),
        ),
        // Temperature Bloc
        BlocProvider(
          create: (context) => TemperatureUnitBloc(),
        ),
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              onGenerateRoute: RoutesGenerators.generateRoute,
            );
          }),
    );
  }
}
