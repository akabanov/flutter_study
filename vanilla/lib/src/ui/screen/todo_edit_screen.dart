import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:vanilla/src/repo/repo_core.dart';
import 'package:vanilla/src/ui/model/todo_list_state.dart';

class TodoEditScreen extends StatefulWidget {
  static const addRouteName = '/add';
  static const updateRouteName = '/update';

  TodoEditScreen({super.key, required this.saveTodo, TodoEntity? initialTodo})
      : initialTodo = initialTodo ??
            TodoEntity(complete: false, id: Uuid().v4(), task: '', note: ''),
        create = initialTodo == null;

  final bool create;
  final TodoEntity initialTodo;
  final TodoAction saveTodo;

  @override
  State<TodoEditScreen> createState() => _TodoEditScreenState();
}

class _TodoEditScreenState extends State<TodoEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.create ? 'Add todo' : 'Update todo'),
      ),
      body: Placeholder(),
    );
  }
}
