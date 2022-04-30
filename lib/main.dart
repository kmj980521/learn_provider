import 'package:flutter/material.dart';
import 'package:learn_provider/ch02_todo/mains.dart';
import 'package:learn_provider/ch03_weatherApp/mains.dart';
import 'package:provider/provider.dart';

import 'ch02-2_stateNotifier/mains.dart';
import 'ch02-3_todo_stateNotifier/mains.dart';

import 'ch03-01_weather_changeNotifier_with_Proxy/mains.dart';
import 'ch03-2_weather_stateNotifierProvider/mains.dart';
import 'ch03_weatherApp/pages/home_page.dart';




void main() {
  runApp(MyWeatherAppStateNotifier());
}
/*
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>(
      create: (_) => AppProvider(),
      child: MaterialApp(
        title: 'addListener of ChangeNotifier',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MyHomePage(),
      ),
    );
  }
}

*/