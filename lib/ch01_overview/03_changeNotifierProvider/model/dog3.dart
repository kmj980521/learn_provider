import 'package:flutter/foundation.dart';

class Dog3 with ChangeNotifier{
  final String name;
  final String breed;
  int age;
  Dog3({
    required this.name,
    required this.breed,
    this.age = 1,
  });

  void grow() {
    age++;
    notifyListeners();
  }
}