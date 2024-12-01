import 'dart:convert';
import 'dart:io';

import 'package:vanilla/repo_core.dart';

class FileTodoRepo implements TodoRepo {
  final String _tag;
  final Future<Directory> Function() _getDirectory;

  FileTodoRepo({required tag, required getDirectory})
      : _tag = tag,
        _getDirectory = getDirectory;

  @override
  Future<List<TodoEntity>> loadTodos() async {
    var file = await _getFile();
    var body = await file.readAsString();
    return JsonDecoder()
        .convert(body)['todos']
        .map<TodoEntity>((todo) => TodoEntity.fromJson(todo))
        .toList();
  }

  @override
  Future<File> saveTodos(List<TodoEntity> todos) async {
    var file = await _getFile();
    return file.writeAsString(JsonEncoder()
        .convert({'todos': todos.map((todo) => todo.toJson()).toList()}));
  }

  Future<void> clean() async {
    var file = await _getFile();
    if (await file.exists()) {
      _getFile().then((f) => f.delete());
    }
  }

  Future<File> _getFile() async {
    var dir = await _getDirectory();
    return File('${dir.path}/${_tag}_todo.json');
  }
}
