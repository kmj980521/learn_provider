import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:learn_provider/ch02_todo/providers/providers.dart';
import 'package:learn_provider/ch02_todo/providers/todo_search.dart';

import '../models/todo_model.dart';
import 'todo_filter.dart';
import 'todo_list.dart';

// Filter된 Todo List
class FilteredTodoState extends Equatable {
  final List<Todo> filteredTodos;

  FilteredTodoState({required this.filteredTodos});

  factory FilteredTodoState.initial() {
    return FilteredTodoState(filteredTodos: []);
  }

  @override
  List<Object> get props => [filteredTodos];

  @override
  bool get stringify => true;

  FilteredTodoState copyWith({List<Todo>? filteredTodos}) {
    return FilteredTodoState(
        filteredTodos: filteredTodos ?? this.filteredTodos);
  }
}

//TodoList와 TodoFilter, TodoSearchTerm을 알아야 표시 가능
class FilteredTodos with ChangeNotifier {
  //FilteredTodoState _state = FilteredTodoState.initial();
  late FilteredTodoState _state;
  final List<Todo> initialFilteredTodos;

  FilteredTodos({required this.initialFilteredTodos}){
   _state = FilteredTodoState(filteredTodos: initialFilteredTodos) ;
  }

  FilteredTodoState get state => _state;

  // 각 argument의 변화가 있을 때마다 호출
  void update(TodoFilter todoFilter, TodoSearch todoSearch, TodoList todoList) {
    List<Todo> _filteredTodos;
    switch (todoFilter.state.filter) {
      // 현재 active 된 Todo를 보려고 한다면
      case Filter.active:
        _filteredTodos =
            todoList.state.todos.where((Todo todo) => !todo.completed).toList();
        break;
      // 현재 completed 된 Todo를 보려고 한다면
      case Filter.completed:
        _filteredTodos =
            todoList.state.todos.where((Todo todo) => todo.completed).toList();
        break;
      // Todo 전부를 보려고 한다면
      case Filter.all:
      default:
        _filteredTodos = todoList.state.todos;
        break;
    }
    // searchTerm을 입력했다면? -> 특정 단어를 포함한 Todo를 출력
    // Todo들을 lowercase로 바꾸고 searchTerm이 포함된 Todo를 가져온다.
    if (todoSearch.state.searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos
          .where(
              (Todo todo) => todo.desc.toLowerCase().contains(todoSearch.state.searchTerm))
          .toList();
    }
    _state = _state.copyWith(filteredTodos: _filteredTodos);
    notifyListeners();
  }
}
