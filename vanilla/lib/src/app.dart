import 'package:flutter/material.dart';
import 'package:vanilla/src/repo/core/todo_entity.dart';
import 'package:vanilla/src/repo/core/todo_repo.dart';
import 'package:vanilla/src/ui/model/todo_list_state.dart';
import 'package:vanilla/src/ui/screen/home_screen.dart';

class App extends StatefulWidget {
  const App({super.key = const Key('app'), required this.todoRepo});

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
      key: const Key('material-app'),
      restorationScopeId: 'todoApp',
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(
              state: _listState,
              addTodo: addTodo,
              updateTodo: updateTodo,
              removeTodo: removeTodo,
            ),
      },
    );
  }

  void addTodo(TodoEntity newTodo) {
    updateState(_listState.copyWithNewTodo(newTodo));
  }

  void updateTodo(TodoEntity update) {
    updateState(_listState.copyWithUpdatedTodo(update));
  }

  void removeTodo(TodoEntity expired) {
    updateState(_listState.copyWithRemovedTodo(expired));
  }

  void updateState(TodoListState newState) {
    setState(() {
      _listState = newState;
      widget.todoRepo.saveTodos(newState.todos);
    });
  }
}
