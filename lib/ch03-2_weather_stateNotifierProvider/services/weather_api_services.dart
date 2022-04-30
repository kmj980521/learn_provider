import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:learn_provider/ch03-2_weather_stateNotifierProvider/constant/constants.dart';
import 'package:learn_provider/ch03-2_weather_stateNotifierProvider/services/http_error_handler.dart';

import '../exceptions/weather_exception.dart';
import '../models/weather.dart';

class WeatherApiServices {
  final http.Client httpClient;

  WeatherApiServices({required this.httpClient});


  //woeid의 정보를 얻는 함수
  Future<int> getWoeid(String city) async {
    final Uri uri = Uri(
        scheme: 'https',
        host: kHost,
        path: '/api/location/search/',
        queryParameters: {'query': city});

    try {
      final http.Response response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      final responseBody = json.decode(response.body);

      if (responseBody.isEmpty) {
        throw WeatherException('Cannot get the woeid of $city');
      }
      // 해당되는 도시가 여러개이다.
      if (responseBody.length > 1) {
        throw WeatherException(
            'There are multiple candidates for $city\n Please specity further!');
      }

      return responseBody[0]['woeid'];
    } catch (e) {
      rethrow; // 별다른 에러처리를 하지 않는다.
    }
  }


  //woeid의 정보를 얻어 날씨의 정보를 얻는 함수
  Future<Weather> getWeather(int woeid) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kHost,
      path: '/api/location/$woeid',
    );

    try {
      final http.Response response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      final weatherJson = json.decode(response.body);

      final Weather weather = Weather.fromJson(weatherJson);

      return weather;
    } catch (e) {
      rethrow;
    }
  }

}
