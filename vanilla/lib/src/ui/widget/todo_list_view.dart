import 'package:flutter/material.dart';
import 'package:vanilla/src/ui/model/todo_list_state.dart';
import 'package:vanilla/src/ui/widget/todo_list_item_view.dart';

class TodoListView extends StatelessWidget {
  const TodoListView(
      {super.key,
      required this.state,
      required this.addTodo,
      required this.updateTodo,
      required this.removeTodo});

  final TodoListState state;
  final TodoAction addTodo;
  final TodoAction updateTodo;
  final TodoAction removeTodo;

  @override
  Widget build(BuildContext context) {
    var todos = state.todos;

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo list'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (_, index) => TodoListItemView(
              todo: todos[index],
              updateTodo: updateTodo,
              removeTodo: removeTodo),
        ),
      ),
    );
  }
}
