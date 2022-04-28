import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../04_extenstionMethod/model/dog4.dart';



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Dog4>(
      create: (context) => Dog4(name: 'dog08', breed: 'breed08', age: 3),
      child: MaterialApp(
        title: 'Provider 08',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider 08'),
      ),
      body: Selector<Dog4, String>(
        selector: (BuildContext context, Dog4 dog)=>dog.name,
        builder: (BuildContext context, String name, Widget? child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                child!,
                SizedBox(height: 10.0,),
                Text(
                  '- name: ${name}',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                BreedAndAge(),
              ],
            ),
          );
        },
        child: Text(
          'I like dogs very much',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}

class BreedAndAge extends StatelessWidget {

  const BreedAndAge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<Dog4, String>(
        selector: (BuildContext context, Dog4 dog)=>dog.breed,
        builder: (_, String breed, __) {
          return Column(
            children: [
              Text(
                '- breed:  ${breed}',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Age(),
            ],
          );
        }
    );
  }
}


class Age extends StatelessWidget {
  const Age({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<Dog4, int>(
        selector: (BuildContext context, Dog4 dog)=>dog.age,
        builder: (_, int age, __) {
          return Column(
            children: [
              Text(
                '- age: ${age}',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 20.0,),
              ElevatedButton(onPressed: () {
                context.read<Dog4>().grow();
              }, child: Text('Grow', style: TextStyle(fontSize: 20.0),))
            ],
          );
        });
  }
}