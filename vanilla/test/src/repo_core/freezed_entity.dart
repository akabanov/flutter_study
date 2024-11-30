import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'freezed_entity.freezed.dart';
part 'freezed_entity.g.dart';

@freezed
class FreezedEntity with _$FreezedEntity {
  const factory FreezedEntity({
    required String id,
  }) = _FreezedEntity;

  factory FreezedEntity.fromJson(Map<String, Object?> json) =>
      _$FreezedEntityFromJson(json);
}
