import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:uuid/uuid.dart';
import 'package:vanilla/src/repo/repo_core.dart';
import 'package:vanilla/src/ui/model/todo_list_state.dart';

class TodoEditScreen extends StatefulWidget {
  static const addRouteName = '/addTodo';
  static const updateRouteName = '/updateTodo';

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

class _TodoEditScreenState extends State<TodoEditScreen> with RestorationMixin {
  final RestorableTextEditingController _taskController =
      RestorableTextEditingController();
  final RestorableTextEditingController _noteController =
      RestorableTextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  String? get restorationId => 'todo_edit_screen';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_taskController, 'task');
    registerForRestoration(_noteController, 'note');
  }

  @override
  void dispose() {
    _taskController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.create ? 'Add todo' : 'Update todo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          onChanged: () => setState(() {}),
          child: ListView(
            children: [
              TextFormField(
                key: Key('todo-task-form-field'),
                autofocus: widget.create,
                controller: _taskController.value,
                decoration: InputDecoration(labelText: 'Task'),
                maxLines: 1,
                textCapitalization: TextCapitalization.sentences,
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return 'Task name can not be empty';
                  }
                  return null;
                },
              ),
              Gap(16),
              TextFormField(
                key: Key('todo-note-form-field'),
                controller: _noteController.value,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(labelText: 'Note'),
                maxLines: 5,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          key: Key('save-todo-btn'),
          onPressed: _formKey.currentState?.validate() ?? false
              ? () {
                  widget.saveTodo(widget.initialTodo.copyWith(
                    task: _taskController.value.text.trim(),
                    note: _noteController.value.text.trim(),
                  ));
                  Navigator.of(context).pop();
                }
              : null,
          child: Icon(Icons.check)),
    );
  }
}
