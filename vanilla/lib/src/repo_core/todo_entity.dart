import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'todo_entity.freezed.dart';
part 'todo_entity.g.dart';

@freezed
class TodoEntity with _$TodoEntity {
  const factory TodoEntity({
    required bool complete,
    required String id,
    required String title,
    required String note,
  }) = _TodoEntity;

  factory TodoEntity.fromJson(Map<String, Object?> json) =>
      _$TodoEntityFromJson(json);
}
