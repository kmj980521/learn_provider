import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:state_notifier/state_notifier.dart';

class BgColorState extends Equatable{
  final Color color;

  BgColorState({required this.color});

  @override
  List<Object> get props => [color];

  @override
  bool get stringify => true;

  BgColorState copyWith({Color? color}){
    return BgColorState(color: color ?? this.color);
  }
}

class BgColor extends StateNotifier<BgColorState>{
  BgColor() : super(BgColorState(color: Colors.blue)); // 초기 state

  // state를 정의한 바가 없는데 사용할 수 있다.
  // notifyListeners()를 호출할 필요가 없다!
  void changeColor(){
    if(state.color == Colors.blue){
      state = state.copyWith(color: Colors.black);
    }
    else if(state.color == Colors.black){
      state = state.copyWith(color: Colors.red);
    }
    else{
      state = state.copyWith(color: Colors.blue);
    }
  }

}