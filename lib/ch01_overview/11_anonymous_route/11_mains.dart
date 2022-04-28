import 'package:flutter/material.dart';
import 'package:learn_provider/ch01_overview/11_anonymous_route/show_me_counter.dart';

import 'package:provider/provider.dart';

import 'model/counter.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider 11',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<Counter>(
          create: (context) => Counter(), child: const MyHomePage()),
    );
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) {
                        return ChangeNotifierProvider.value(
                          value: context.read<Counter>(),
                          child: ShowMeCounter(),
                        );
                      }),
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
