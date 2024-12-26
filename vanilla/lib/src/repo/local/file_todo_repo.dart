import 'dart:convert';
import 'dart:io';

import 'package:vanilla/src/repo/repo_core.dart';

class FileTodoRepo implements TodoRepo {
  final String _tag;
  final Future<Directory> Function() _getDirectory;

  FileTodoRepo(
      {required String tag, required Future<Directory> Function() getDirectory})
      : _tag = tag,
        _getDirectory = getDirectory;

  Future<File> _getFile() async {
    var directory = await _getDirectory();
    return File("${directory.path}/${_tag}_todo.json");
  }

  @override
  Future<File> saveTodos(List<TodoEntity> todos) async {
    var file = await _getFile();
    return file.writeAsString(const JsonEncoder()
        .convert({'todos': todos.map((todo) => todo.toJson()).toList()}));
  }

  @override
  Future<List<TodoEntity>> loadTodos() async {
    var content = await _getFile().then((f) => f.readAsString());
    return const JsonDecoder()
        .convert(content)['todos']
        .map<TodoEntity>((json) => TodoEntity.fromJson(json))
        .toList();
  }
}
