import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../04_extenstionMethod/model/dog4.dart';
import 'model/babies.dart';



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Dog4>(
          create: (context) => Dog4(name: 'dog06', breed: 'breed06', age: 3),),
        FutureProvider<int>(initialData: 0, create: (context) {
          final int dogAge = context
              .read<Dog4>()
              .age;
          final babies = Babies(age: dogAge);
          return babies.getBabies();
        },)
      ],
      child: MaterialApp(
        title: 'Provider 05',
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
        title: Text('Provider 04'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '- name: ${context
                  .watch<Dog4>()
                  .name}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            BreedAndAge(),
          ],
        ),
      ),
    );
  }
}

class BreedAndAge extends StatelessWidget {

  const BreedAndAge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '- breed:  ${context.select<Dog4, String>((Dog4 dog) => dog.breed)}',
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(
          height: 10.0,
        ),
        Age(),
      ],
    );
  }
}

class Age extends StatelessWidget {
  const Age({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '- age: ${context.select<Dog4, int>((Dog4 dog) => dog.age)}',
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(height: 10.0,),
        Text(
          '- number of babies:${context.watch<int>()}',
          style: TextStyle(
              fontSize: 20.0
          ),),
        SizedBox(height: 20.0,),
        ElevatedButton(onPressed: () {
          context.read<Dog4>().grow();
        }, child: Text('Grow', style: TextStyle(fontSize: 20.0),))
      ],
    );
  }
}
