import 'package:flutter/material.dart';
import 'package:learn_provider/ch01_overview/11_anonymous_route/show_me_counter.dart';
import 'package:provider/provider.dart';

import '../11_anonymous_route/model/counter.dart';


class MyApp extends StatefulWidget {

  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Counter _counter = Counter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider 11',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => ChangeNotifierProvider.value(value: _counter,child: MyHomePage()),
        '/counter': (context) => ChangeNotifierProvider.value(value: _counter ,child: ShowMeCounter()),
      },
    );
  }
  @override
  void dispose() {
    _counter.dispose();
    super.dispose();
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context,
                        '/counter'
                    );
                  },
                  child: Text(
                    'Show Me Counter',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<Counter>().increment();
                  },
                  child: Text(
                    'Increment Counter',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
