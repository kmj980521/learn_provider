

import 'package:learn_provider/ch03-2_weather_stateNotifierProvider/exceptions/weather_exception.dart';
import 'package:learn_provider/ch03-2_weather_stateNotifierProvider/models/custom_error.dart';
import 'package:learn_provider/ch03-2_weather_stateNotifierProvider/services/weather_api_services.dart';

import '../models/weather.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;
  WeatherRepository({
    required this.weatherApiServices,
  });

  Future<Weather> fetchWeather(String city) async {
    try {
      final int woeid = await weatherApiServices.getWoeid(city);
      print('woeid: $woeid');

      final Weather weather = await weatherApiServices.getWeather(woeid);
      print('weather: $weather');

      return weather;
    } on WeatherException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}