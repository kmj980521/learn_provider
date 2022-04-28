import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../13_proxyprovider/pages/chgnotiprov_proxyprov.dart';
import 'pages/counter_page.dart';
import 'pages/handle_dialog_page.dart';
import 'pages/navigate_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Counter>(
      create: (_)=>Counter(),
      child: MaterialApp(
        title: 'addPostFrameCallback',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue
        ),
        home: MyHomePage(),
      ),
    );
  }
}
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              ElevatedButton(
                child: Text(
                  'Counter Page',
                  style: TextStyle(fontSize: 20.0),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CounterPage(),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text(
                  'Handle Dialog Page',
                  style: TextStyle(fontSize: 20.0),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HandleDialogPage(),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text(
                  'Navigate Page',
                  style: TextStyle(fontSize: 20.0),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NavigatePage(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
