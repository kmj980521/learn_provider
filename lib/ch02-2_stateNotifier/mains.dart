import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:learn_provider/ch02-2_stateNotifier/providers/bg_color.dart';
import 'package:learn_provider/ch02-2_stateNotifier/providers/counter.dart';
import 'package:learn_provider/ch02-2_stateNotifier/providers/customer_level.dart';
import 'package:provider/provider.dart';

class MyStateNotifier extends StatelessWidget {
  const MyStateNotifier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StateNotifierProvider<BgColor,BgColorState>(create: (context)=>BgColor()),
        StateNotifierProvider<Counter,CounterState>(create: (context)=>Counter()),
        StateNotifierProvider<CustomerLevel,Level>(create: (context)=>CustomerLevel()),
      ],
      child: MaterialApp(
        title: 'TODOS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePageStateNotifier(),
      ),
    );
  }
}

class MyHomePageStateNotifier extends StatelessWidget {
  const MyHomePageStateNotifier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorState = context.watch<BgColorState>(); // state 자체를 return
    final counterState = context.watch<CounterState>();
    final levelState = context.watch<Level>();
    return Scaffold(
      backgroundColor: levelState == Level.bronze ? Colors.white : levelState == Level.silver ? Colors.grey : Colors.yellow,
      appBar: AppBar(
        title: Text('StateNotifier'),
        backgroundColor: colorState.color,
      ),
      body: Center(
        child: Text(
          '${counterState.counter}',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              onPressed: (){
                context.read<Counter>().increment();
              },
            child: Icon(Icons.add),
            tooltip: 'Increment',
          ),
          SizedBox(width: 10.0,),
          FloatingActionButton(
            onPressed: (){
              context.read<BgColor>().changeColor();
            },
            child: Icon(Icons.color_lens_outlined),
            tooltip: 'Change color',
          ),

        ],
      ),
    );
  }
}
