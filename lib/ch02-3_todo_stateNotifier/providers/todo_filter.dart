import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:state_notifier/state_notifier.dart';

import '../models/todo_model.dart';

// 특정 Todo의 Filter를 변경
class TodoFilterState extends Equatable {
  final Filter filter;

  TodoFilterState({required this.filter});

  // 처음엔 필터를 하지 않는다.
  // 정의한 Filter enum
  // enum Filter {
  //   all,
  //   active,
  //   completed,
  // }
  factory TodoFilterState.initial(){
    return TodoFilterState(filter: Filter.all);
  }


  @override
  List<Object> get props => [filter];

  @override
  bool get stringify => true;

  TodoFilterState copyWith({
    Filter? filter,
  }) {
    return TodoFilterState(filter: filter ?? this.filter);
  }
}

class TodoFilter extends StateNotifier<TodoFilterState>{

  TodoFilter() : super(TodoFilterState.initial());

  void changeFilter(Filter newFilter){
    state = state.copyWith(filter: newFilter); // 새로운 state를 만들고 새로 알려준다.
  }
}


