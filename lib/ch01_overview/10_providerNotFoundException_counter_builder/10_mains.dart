import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/counter.dart';


void main() {
  runApp(const MyApp());
}

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ChangeNotifierProvider<Counter>(
          create: (_) => Counter(),
          child: Builder(
            builder: (context) {
              return ChildWidget();
            },
          ),
        ),
      ),
    );
  }
}

class ChildWidget extends StatelessWidget {
  const ChildWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${context.watch<Counter>().counter}',
          style: TextStyle(fontSize: 48.0),
        ),
        SizedBox(height: 20.0),
        ElevatedButton(
          child: Text(
            'Increment',
            style: TextStyle(fontSize: 20.0),
          ),
          onPressed: () {
            context.read<Counter>().increment();
          },
        )
      ],
    );
  }
}