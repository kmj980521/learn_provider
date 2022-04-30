// api 호출에 따른 state

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:learn_provider/ch03_weatherApp/repositories/weather_repository.dart';

import '../models/custom_error.dart';
import '../models/weather.dart';

enum WeatherStatus{
  initial,
  loading,
  loaded,
  error
}

class WeatherState extends Equatable{
  final WeatherStatus status;
  final Weather weather;
  final CustomError error;

  WeatherState({required this.status, required this.weather, required this.error});

  factory WeatherState.initial(){
    return WeatherState(status: WeatherStatus.initial, weather: Weather.initial(), error: CustomError(),);
  }

  @override
  // TODO: implement props
  List<Object> get props => [status, weather, error];

  @override
  bool get stringify => true;

  WeatherState copyWith({WeatherStatus? status, Weather? weather, CustomError? error}){
    return WeatherState(status: status ?? this.status , weather: weather ?? this.weather , error: error ?? this.error);
  }
}

class WeatherProvider with ChangeNotifier {
  WeatherState _state = WeatherState.initial();

  WeatherProvider({required this.weatherRepository});
  WeatherState get state => _state;



  final WeatherRepository weatherRepository;

  Future<void> fetchWeather(String city) async{
    _state = _state.copyWith(status: WeatherStatus.loading);
    notifyListeners();

    try{
      final Weather weather = await weatherRepository.fetchWeather(city);

      _state = _state.copyWith(status: WeatherStatus.loaded,weather: weather);
      notifyListeners();
    } on CustomError catch (e){
      _state = _state.copyWith(status: WeatherStatus.error, error: e);
      notifyListeners();
    }
  }
}

