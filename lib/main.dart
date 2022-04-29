import 'package:flutter/material.dart';
import 'package:learn_provider/ch02_todo/mains.dart';
import 'package:provider/provider.dart';

import 'ch02-2_stateNotifier/mains.dart';
import 'ch02-3_todo_stateNotifier/mains.dart';




void main() {
  runApp(MyTodoAppRefactor_StateNotifier());
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