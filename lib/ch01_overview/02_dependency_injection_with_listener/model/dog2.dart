import 'package:flutter/foundation.dart';

class Dog2 with ChangeNotifier{
  final String name;
  final String breed;
  int age;
  Dog2({
    required this.name,
    required this.breed,
    this.age = 1,
  });

  void grow() {
    age++;
    notifyListeners();
    print('age: $age');
  }
}