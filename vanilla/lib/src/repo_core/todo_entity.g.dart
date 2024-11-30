// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoEntityImpl _$$TodoEntityImplFromJson(Map<String, dynamic> json) =>
    _$TodoEntityImpl(
      complete: json['complete'] as bool,
      id: json['id'] as String,
      title: json['title'] as String,
      note: json['note'] as String,
    );

Map<String, dynamic> _$$TodoEntityImplToJson(_$TodoEntityImpl instance) =>
    <String, dynamic>{
      'complete': instance.complete,
      'id': instance.id,
      'title': instance.title,
      'note': instance.note,
    };
