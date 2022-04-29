import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:state_notifier/state_notifier.dart';

import '../models/todo_model.dart';
import 'todo_list.dart';

// 수행 중인 Active Todo List
class ActiveTodoCountState extends Equatable {
  final int activeTodoCount;

  ActiveTodoCountState({required this.activeTodoCount});

  factory ActiveTodoCountState.initial() {
    return ActiveTodoCountState(activeTodoCount: 0);
  }

  @override
  List<Object> get props => [activeTodoCount];

  @override
  bool? get stringify => true;

  ActiveTodoCountState copyWith({int? activeTodoCount}) {
    return ActiveTodoCountState(
        activeTodoCount: activeTodoCount ?? this.activeTodoCount);
  }
}

class ActiveTodoCount extends StateNotifier<ActiveTodoCountState>
    with LocatorMixin {
  ActiveTodoCount() : super(ActiveTodoCountState.initial());

  // ActiveTodoCountState get state => ActiveTodoCountState(activeTodoCount: todoList.state.todos.where((Todo todo) => !todo.completed).toList().length);
  @override
  void update(Locator watch) {
    final List<Todo> todos = watch<TodoListState>().todos;
    state = state.copyWith(
        activeTodoCount:todos
            .where((Todo todo) => !todo.completed)
            .toList()
            .length);
    super.update(watch);
  }
}
