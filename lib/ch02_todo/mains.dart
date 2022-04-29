import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/providers.dart';
import 'pages/todos_page.dart';

class MyTodoApp extends StatelessWidget {
  const MyTodoApp({Key? key}) : super(key: key);

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
        ChangeNotifierProxyProvider<TodoList, ActiveTodoCount>(
          create: (context) => ActiveTodoCount(initialActiveTodoCount: context.read<TodoList>().state.todos.length),

          // buildContext, ActiveTodoCount가 의존하는 TodoList, nullable
          update: (BuildContext context, TodoList todoList,
                  ActiveTodoCount? activeTodoCount) =>
              activeTodoCount!..update(todoList),
        ),
        ChangeNotifierProxyProvider3<TodoFilter,TodoSearch,TodoList,FilteredTodos>(
          create: (context)=>FilteredTodos(
            initialFilteredTodos: context.read<TodoList>().state.todos
          ) ,
          update: (BuildContext context, TodoFilter todoFilter, TodoSearch todoSearch, TodoList todoList, FilteredTodos? filteredTodos )=>filteredTodos!..update(todoFilter, todoSearch, todoList),
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
