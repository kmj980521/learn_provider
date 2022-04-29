import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/providers.dart';
import 'pages/todos_page.dart';

class MyTodoAppRefactor extends StatelessWidget {
  const MyTodoAppRefactor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoFilter>(
          create: (context) => TodoFilter(),
        ),
        ChangeNotifierProvider<TodoSearch>(
          create: (context) => TodoSearch(),
        ),
        ChangeNotifierProvider<TodoList>(
          create: (context) => TodoList(),
        ),
        ProxyProvider<TodoList, ActiveTodoCount>(

          // buildContext, ActiveTodoCount가 의존하는 TodoList, nullable
          update: (BuildContext context, TodoList todoList,
                  ActiveTodoCount? _) =>
              ActiveTodoCount(todoList: todoList),
        ),
        ProxyProvider3<TodoFilter,TodoSearch,TodoList,FilteredTodos>(
          update: (BuildContext context, TodoFilter todoFilter, TodoSearch todoSearch, TodoList todoList, FilteredTodos? _ )=>
          FilteredTodos(todoFilter: todoFilter, todoSearch: todoSearch, todoList: todoList),
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
