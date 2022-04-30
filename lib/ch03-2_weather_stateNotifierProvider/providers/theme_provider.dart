import 'package:equatable/equatable.dart';

import 'package:learn_provider/ch03-2_weather_stateNotifierProvider/constant/constants.dart';
import 'package:state_notifier/state_notifier.dart';

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

class ThemeProvider extends StateNotifier<ThemeState> with LocatorMixin {
  ThemeProvider() : super(ThemeState.initial());

  @override
  void update(Locator watch) {
    final wp = watch<WeatherState>().weather;

    if (wp.theTemp > kWarmOrNot) {
      state = state.copyWith(appTheme: AppTheme.light);
    } else {
      state = state.copyWith(appTheme: AppTheme.dark);
    }

    super.update(watch);
  }
}