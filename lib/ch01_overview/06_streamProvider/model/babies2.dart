class Babies2{
  final int age;

  Babies2({required this.age,});

  Future<int> getBabies() async{
    await Future.delayed(Duration(seconds: 3));

    if (age>1 && age<5){
      return 4;
    }else if (age<=1){
      return 0;
    }else{
      return 2;
    }
  }
  Stream<String> bark() async*{
    for(int i=1;i<age;i++){
         await Future.delayed(Duration(seconds: 2));
         yield 'Bark $i times';
    }
  }
}

