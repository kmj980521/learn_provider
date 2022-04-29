import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:learn_provider/ch02-2_stateNotifier/providers/bg_color.dart';
import 'package:state_notifier/state_notifier.dart';

class CounterState extends Equatable{
  final int counter;

  CounterState({required this.counter});

  @override
  List<Object> get props => [counter];

  @override
  bool get stringify => true;

  CounterState copyWith({int? counter}){
    return CounterState(counter: counter ?? this.counter);
  }
}
// ProxyProvider를 안 만들고 read, watch를 사용하기 위해서 LocatorMixin을 with 한다.
class Counter extends StateNotifier<CounterState> with LocatorMixin{
  Counter(): super(CounterState(counter: 0));

  void increment(){
    Color currentColor = read<BgColor>().state.color;
    if(currentColor == Colors.black){
      state = state.copyWith(counter: state.counter + 10);
    }
    else if(currentColor == Colors.red){
      state = state.copyWith(counter: state.counter - 10);
    }
    else{
      state = state.copyWith(counter: state.counter + 1);
    }
  }
  // 다른 object의 update를 listening 할 수 있게 하고,
  // ProxyProvider가 provider에 하는 것과 동일하다.
  // flutter 외부에서도 사용할 수 있고, 위젯트리 밖에서도 사용할 수 있다.
  // 또한, 업데이트 함수 내에서는 read를 할 수 없고 update 함수의 argument를 이용한다.
  // object를 읽는 것 외에 변화를 watch 할 수 있다.
  @override
  void update(Locator watch) {
    super.update(watch);
  }
}