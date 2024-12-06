import 'package:flutter/material.dart';
import 'package:vanilla/src/repo/core/todo_repo.dart';
import 'package:vanilla/src/ui/model/todo_list_state.dart';
import 'package:vanilla/src/ui/screen/todo_list_screen.dart';

class App extends StatefulWidget {
  const App({super.key, required this.todoRepo});

  final TodoRepo todoRepo;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late TodoListState _listState;

  @override
  void initState() {
    super.initState();

    _listState = TodoListState.loading();
    widget.todoRepo
        .loadTodos()
        .then((todos) => setState(() => _listState = TodoListState(todos)))
        .catchError((error) =>
            setState(() => _listState = TodoListState.error(error.toString())));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        onGenerateRoute: (settings) => switch (settings.name) {
              (TodoListScreen.routeName || _) => MaterialPageRoute(
                  builder: (_) => TodoListScreen(todoListState: _listState))
            });
  }
}
