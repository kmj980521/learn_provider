import 'package:flutter/material.dart';
import 'package:learn_provider/ch03_weatherApp/providers/temp_settings_provider.dart';
import 'package:learn_provider/ch03_weatherApp/providers/weather_provider.dart';
import 'package:learn_provider/ch03_weatherApp/repositories/weather_repository.dart';
import 'package:learn_provider/ch03_weatherApp/services/weather_api_services.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'pages/home_page.dart';
import 'providers/theme_provider.dart';

class MyWeatherApp extends StatelessWidget {
  const MyWeatherApp({Key? key}) : super(key: key);

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

        ChangeNotifierProvider<WeatherProvider>(
          create: (context) =>
              WeatherProvider(weatherRepository: context.read<WeatherRepository>()),
        ),
        ChangeNotifierProxyProvider<WeatherProvider, ThemeProvider>(
          create: (context) => ThemeProvider(),
          update: (
            BuildContext context,
            WeatherProvider weatherProvider,
            ThemeProvider? themeProvider,
          ) => themeProvider!..update(weatherProvider),
        ),

        ChangeNotifierProvider<TempSettingsProvider>(
            create: (context)=> TempSettingsProvider()
        ),
      ],
      builder:(context,_)=> MaterialApp(
        title: 'Flutter Demo',
        theme: context.watch<ThemeProvider>().state.appTheme == AppTheme.light ? ThemeData.light() : ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: HomeWeatherPage(),
      ),
    );
  }
}
