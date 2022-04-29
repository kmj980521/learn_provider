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

class ActiveTodoCount {
  final TodoList todoList;

  ActiveTodoCount({required this.todoList});
  
  ActiveTodoCountState get state => ActiveTodoCountState(activeTodoCount: todoList.state.todos.where((Todo todo) => !todo.completed).toList().length);
}