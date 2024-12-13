import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vanilla/src/repo/core/todo_entity.dart';
import 'package:vanilla/src/repo/core/todo_repo.dart';
import 'package:vanilla/src/ui/model/todo_list_state.dart';
import 'package:vanilla/src/ui/screen/loading_error_screen.dart';
import 'package:vanilla/src/ui/screen/loading_screen.dart';
import 'package:vanilla/src/ui/screen/todo_edit_screen.dart';
import 'package:vanilla/src/ui/screen/todo_list_screen.dart';

class App extends StatefulWidget {
  const App({super.key = const Key('app'), required this.todoRepo});

  final TodoRepo todoRepo;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late TodoListState _listState;

  late final _router = GoRouter(
    restorationScopeId: 'router',
    initialLocation: LoadingScreen.routeName,
    routes: [
      GoRoute(
          path: TodoListScreen.routeName,
          builder: (_, __) => TodoListScreen(
                addTodo: addTodo,
                updateTodo: updateTodo,
                removeTodo: removeTodo,
              )),
      GoRoute(
          path: LoadingScreen.routeName, builder: (_, __) => LoadingScreen()),
      GoRoute(
          path: LoadingErrorScreen.routeName,
          builder: (_, __) =>
              LoadingErrorScreen(errorMessage: _listState.error)),
      GoRoute(
        path: TodoEditScreen.addRouteName,
        builder: (_, __) => TodoEditScreen(saveTodo: addTodo),
      )
    ],
  );

  @override
  void initState() {
    super.initState();

    _listState = TodoListState.loading();
    widget.todoRepo
        .loadTodos()
        .then((todos) => setState(() {
              _listState = TodoListState(todos);
              _router.go(TodoListScreen.routeName);
            }))
        .catchError((error) => setState(() {
              _listState = TodoListState.error(error.toString());
              _router.go(LoadingErrorScreen.routeName);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Provider<TodoListState>.value(
      value: _listState,
      child: MaterialApp.router(
        key: const Key('material-app'),
        restorationScopeId: 'todoApp',
        routerConfig: _router,
      ),
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
