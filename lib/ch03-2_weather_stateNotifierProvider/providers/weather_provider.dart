// api 호출에 따른 state

import 'package:equatable/equatable.dart';
import 'package:learn_provider/ch03-2_weather_stateNotifierProvider/repositories/weather_repository.dart';
import 'package:state_notifier/state_notifier.dart';

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

class WeatherProvider extends StateNotifier<WeatherState> with LocatorMixin {

  WeatherProvider() : super(WeatherState.initial());

  Future<void> fetchWeather(String city) async{
    state = state.copyWith(status: WeatherStatus.loading);
    try{
      final Weather weather = await read<WeatherRepository>().fetchWeather(city);
      state = state.copyWith(status: WeatherStatus.loaded,weather: weather);
    } on CustomError catch (e){
      state = state.copyWith(status: WeatherStatus.error, error: e);
    }
  }
}

