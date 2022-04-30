import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:learn_provider/ch03-01_weather_changeNotifier_with_Proxy/constant/constants.dart';

import 'weather_provider.dart';

enum AppTheme{
  light,
  dark,

}

class ThemeState extends Equatable{
  final AppTheme appTheme;

  ThemeState({this.appTheme = AppTheme.light});

  factory ThemeState.initial(){
    return ThemeState();
  }

  @override
  // TODO: implement props
  List<Object> get props => [appTheme];

  @override
  bool get stringify => true;

  ThemeState copyWith({
    AppTheme? appTheme,
  }) {
    return ThemeState(
      appTheme: appTheme ?? this.appTheme,
    );
  }
}

class ThemeProvider{
  final WeatherProvider weatherProvider;

  ThemeProvider({required this.weatherProvider});

  ThemeState get state {
    if(weatherProvider.state.weather.theTemp>kWarmOrNot){
     return ThemeState();
    }else{
      return ThemeState(appTheme: AppTheme.dark);
    }
  }
}