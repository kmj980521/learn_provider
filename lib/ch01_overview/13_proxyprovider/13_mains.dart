import 'package:flutter/material.dart';
import 'package:learn_provider/ch01_overview/11_anonymous_route/show_me_counter.dart';
import 'package:provider/provider.dart';

import 'pages/chgnotiprov_chgnotiproxyprov.dart';
import 'pages/chgnotiprov_proxyprov.dart';
import 'pages/proxyprov_create_update.dart';
import 'pages/proxyprov_proxyprov.dart';
import 'pages/proxyprov_update.dart';
import 'pages/why_proxyprov.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anonymous Route',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
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
                  'Why\nProxyProvider',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => WhyProxyProv(),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text(
                  'ProxyProvider\nupdate',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProxyProvUpdate(),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text(
                  'ProxyProvider\ncreate/update',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProxyProvCreateUpdate(),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text(
                  'ProxyProvider\nProxyProvider',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProxyProvProxyProv(),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text(
                  'ChangeNotifierProvider\nChangeNotifierProxyProvider',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChgNotiProvChgNotiProxyProv(),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text(
                  'ChangeNotifierProvider\nProxyProvider',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChgNotiProvProxyProv(),
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