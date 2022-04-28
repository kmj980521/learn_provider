import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider 09',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomepage(),
    );
  }
}

class MyHomepage extends StatelessWidget {
  const MyHomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider 09'),
      ),
      body: ChangeNotifierProvider<Foo>(
          create: (_)=>Foo(),
          child: Consumer<Foo>(
            builder: (BuildContext context, Foo foo, Widget?_){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${foo.value}',style: TextStyle(fontSize: 40),
                    ),
                    SizedBox(height: 20.0,),
                    ElevatedButton(
                      onPressed: (){
                        foo.changeValue();
                      },
                      child: Text(
                        'Change Value',style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
      ),
    );
  }
}

class Foo with ChangeNotifier{
  String value = 'Foo';
  void changeValue(){
    value = value == 'Foo'? 'Bar' : 'Foo';
    notifyListeners();
  }
}




