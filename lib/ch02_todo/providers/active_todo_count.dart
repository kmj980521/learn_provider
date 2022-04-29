import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../models/todo_model.dart';
import 'todo_list.dart';


// 수행 중인 Active Todo List
class ActiveTodoCountState extends Equatable{
  final int activeTodoCount;

  ActiveTodoCountState({ required this.activeTodoCount});

  factory ActiveTodoCountState.initial(){
    return ActiveTodoCountState(activeTodoCount: 0);
  }


  @override
  List<Object> get props => [activeTodoCount];

  @override
  bool? get stringify => true;

  ActiveTodoCountState copyWith({int? activeTodoCount}){
    return ActiveTodoCountState(activeTodoCount: activeTodoCount ?? this.activeTodoCount);
  }
}

class ActiveTodoCount with ChangeNotifier{
  //ActiveTodoCountState _state = ActiveTodoCountState.initial();

  late ActiveTodoCountState _state; // constructor에서 넘어온 값을 알아야만 생성되기 때문에

  final int initialActiveTodoCount;

  ActiveTodoCount({required this.initialActiveTodoCount}){
    _state = ActiveTodoCountState(activeTodoCount: initialActiveTodoCount);
  }
  ActiveTodoCountState get state => _state;

  //ProxyProvider를 사용
  // 의존하는 값(todoList)이 수시로 바뀌기 때문에 ProxyProvider 사용이 적합하다.
  void update(TodoList todoList){
      final int newActiveTodoCount = todoList.state.todos.where((Todo todo) => !todo.completed).toList().length;

      _state = _state.copyWith(activeTodoCount: newActiveTodoCount);
      notifyListeners();
  }
}