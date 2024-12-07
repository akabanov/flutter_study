import 'package:flutter/material.dart';
import 'package:vanilla/src/repo/core/todo_entity.dart';
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
            builder: (_) => TodoListScreen(
              state: _listState,
              addTodo: addTodo,
              updateTodo: updateTodo,
              removeTodo: removeTodo,
            ),
          ),
      },
    );
  }

  void addTodo(TodoEntity newTodo) {
    updateTodoList(() => _listState.copyWithNewTodo(newTodo));
  }

  void updateTodo(TodoEntity update) {
    updateTodoList(() => _listState.copyWithUpdatedTodo(update));
  }

  void removeTodo(TodoEntity expired) {
    updateTodoList(() => _listState.copyWithRemovedTodo(expired));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${expired.task} removed'),
      duration: Duration(seconds: 3),
      action: SnackBarAction(
        label: 'undo',
        onPressed: () => addTodo(expired),
      ),
    ));
  }

  void updateTodoList(TodoListState Function() convert) {
    setState(() {
      _listState = convert();
      widget.todoRepo.saveTodos(_listState.todos);
    });
  }
}
