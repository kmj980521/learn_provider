import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'providers/providers.dart';
import 'pages/todos_page.dart';

class MyTodoAppRefactor_StateNotifier extends StatelessWidget {
  const MyTodoAppRefactor_StateNotifier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StateNotifierProvider<TodoFilter, TodoFilterState>(
          create: (context) => TodoFilter(),
        ),
        StateNotifierProvider<TodoSearch, TodoSearchState>(
          create: (context) => TodoSearch(),
        ),
        StateNotifierProvider<TodoList, TodoListState>(
          create: (context) => TodoList(),
        ),
        StateNotifierProvider<ActiveTodoCount, ActiveTodoCountState>(
          create: (context) => ActiveTodoCount(),
        ),
        StateNotifierProvider<FilteredTodos,FilteredTodoState>(
          create: (context)=>FilteredTodos() ,
        ),

      ],
      child: MaterialApp(
        title: 'TODOS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TodosPage(),
      ),
    );
  }
}
