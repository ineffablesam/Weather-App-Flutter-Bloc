import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

import '../../consts.dart';

class WeatherRepository {
  Future<Response> getWeatherDataByCity(String city) async {
    Map<String, String> queryParameters = {
      'q': city,
      'appid': Constants.apiKey,
      'units': 'metric'
    };

    final cityResponse = await get(
        Uri.https(Constants.baseUrl, Constants.cityEndPoint, queryParameters));

    return cityResponse;
  }

  Future<Response> getWeatherDataByLocation() async {
    final geolocator = await _determinePosition();
    Map<String, dynamic> queryParameters = {
      'lat': geolocator.latitude.toString(),
      'lon': geolocator.longitude.toString(),
      'appid': Constants.apiKey,
      'units': 'metric'
    };
    final locationResponse = await post(Uri.https(
        Constants.baseUrl, Constants.locationEndPoint, queryParameters));

    return locationResponse;
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
}
