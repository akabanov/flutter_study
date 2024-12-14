import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vanilla/src/repo/repo_core.dart';
import 'package:vanilla/src/ui/model/todo_list_state.dart';

class TodoEditScreen extends StatefulWidget {
  static const addRouteName = 'addTodo';
  static const updateRouteName = 'updateTodo';

  const TodoEditScreen({super.key, required this.saveTodo, this.todoId});

  final String? todoId;
  final TodoAction saveTodo;

  @override
  State<TodoEditScreen> createState() => _TodoEditScreenState();
}

class _TodoEditScreenState extends State<TodoEditScreen> with RestorationMixin {
  late final bool _create;
  late final TodoEntity _template;

  late final RestorableTextEditingController _taskController;
  late final RestorableTextEditingController _noteController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    var todoId = widget.todoId;
    var state = context.read<TodoListState>();

    _create = todoId == null;
    _template = todoId != null && state.status == TodoListStateStatus.ready
        ? state.get(todoId)
        : TodoEntity.seed();
    _taskController = RestorableTextEditingController(text: _template.task);
    _noteController = RestorableTextEditingController(text: _template.note);
  }

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
        title: Text(_create ? 'Add todo' : 'Update todo'),
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
                autofocus: _create,
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
                  widget.saveTodo(_template.copyWith(
                    task: _taskController.value.text.trim(),
                    note: _noteController.value.text.trim(),
                  ));
                  context.pop();
                }
              : null,
          child: Icon(Icons.check)),
    );
  }
}
