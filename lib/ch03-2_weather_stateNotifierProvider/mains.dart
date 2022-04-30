import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:learn_provider/ch03-2_weather_stateNotifierProvider/providers/temp_settings_provider.dart';
import 'package:learn_provider/ch03-2_weather_stateNotifierProvider/providers/weather_provider.dart';
import 'package:learn_provider/ch03-2_weather_stateNotifierProvider/repositories/weather_repository.dart';
import 'package:learn_provider/ch03-2_weather_stateNotifierProvider/services/weather_api_services.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'pages/home_page.dart';
import 'providers/theme_provider.dart';

class MyWeatherAppStateNotifier extends StatelessWidget {
  const MyWeatherAppStateNotifier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // 그냥 프로바이더는 데이터나 서비스를 공유하는 데에 편리하다
        Provider<WeatherRepository>(
          create: (context) {
            final WeatherApiServices weatherApiServices = WeatherApiServices(httpClient: http.Client());
            return WeatherRepository(weatherApiServices: weatherApiServices);
          },
        ),

        StateNotifierProvider<WeatherProvider, WeatherState>(
          create: (context) => WeatherProvider(),
        ),
        StateNotifierProvider<TempSettingsProvider, TempSettingsState>(
          create: (context)=>TempSettingsProvider(),
        ),
        StateNotifierProvider<ThemeProvider,ThemeState>(
            create: (context)=> ThemeProvider()
        ),
      ],
      builder:(context,_)=> MaterialApp(
        title: 'Flutter Demo',
        theme: context.watch<ThemeState>().appTheme == AppTheme.light ? ThemeData.light() : ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: HomeWeatherPage(),
      ),
    );
  }
}
