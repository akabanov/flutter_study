// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TodoEntity _$TodoEntityFromJson(Map<String, dynamic> json) {
  return _TodoEntity.fromJson(json);
}

/// @nodoc
mixin _$TodoEntity {
  bool get complete => throw _privateConstructorUsedError;

  String get id => throw _privateConstructorUsedError;

  String get task => throw _privateConstructorUsedError;

  String get note => throw _privateConstructorUsedError;

  /// Serializes this TodoEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TodoEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TodoEntityCopyWith<TodoEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoEntityCopyWith<$Res> {
  factory $TodoEntityCopyWith(
          TodoEntity value, $Res Function(TodoEntity) then) =
      _$TodoEntityCopyWithImpl<$Res, TodoEntity>;

  @useResult
  $Res call({bool complete, String id, String task, String note});
}

/// @nodoc
class _$TodoEntityCopyWithImpl<$Res, $Val extends TodoEntity>
    implements $TodoEntityCopyWith<$Res> {
  _$TodoEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;

  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodoEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? complete = null,
    Object? id = null,
    Object? task = null,
    Object? note = null,
  }) {
    return _then(_value.copyWith(
      complete: null == complete
          ? _value.complete
          : complete // ignore: cast_nullable_to_non_nullable
              as bool,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      task: null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as String,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TodoEntityImplCopyWith<$Res>
    implements $TodoEntityCopyWith<$Res> {
  factory _$$TodoEntityImplCopyWith(
          _$TodoEntityImpl value, $Res Function(_$TodoEntityImpl) then) =
      __$$TodoEntityImplCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call({bool complete, String id, String task, String note});
}

/// @nodoc
class __$$TodoEntityImplCopyWithImpl<$Res>
    extends _$TodoEntityCopyWithImpl<$Res, _$TodoEntityImpl>
    implements _$$TodoEntityImplCopyWith<$Res> {
  __$$TodoEntityImplCopyWithImpl(
      _$TodoEntityImpl _value, $Res Function(_$TodoEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of TodoEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? complete = null,
    Object? id = null,
    Object? task = null,
    Object? note = null,
  }) {
    return _then(_$TodoEntityImpl(
      complete: null == complete
          ? _value.complete
          : complete // ignore: cast_nullable_to_non_nullable
              as bool,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      task: null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as String,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TodoEntityImpl with DiagnosticableTreeMixin implements _TodoEntity {
  const _$TodoEntityImpl(
      {required this.complete,
      required this.id,
      required this.task,
      required this.note});

  factory _$TodoEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodoEntityImplFromJson(json);

  @override
  final bool complete;
  @override
  final String id;
  @override
  final String task;
  @override
  final String note;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TodoEntity(complete: $complete, id: $id, task: $task, note: $note)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TodoEntity'))
      ..add(DiagnosticsProperty('complete', complete))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('task', task))
      ..add(DiagnosticsProperty('note', note));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoEntityImpl &&
            (identical(other.complete, complete) ||
                other.complete == complete) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.task, task) || other.task == task) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, complete, id, task, note);

  /// Create a copy of TodoEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoEntityImplCopyWith<_$TodoEntityImpl> get copyWith =>
      __$$TodoEntityImplCopyWithImpl<_$TodoEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodoEntityImplToJson(
      this,
    );
  }
}

abstract class _TodoEntity implements TodoEntity {
  const factory _TodoEntity(
      {required final bool complete,
      required final String id,
      required final String task,
      required final String note}) = _$TodoEntityImpl;

  factory _TodoEntity.fromJson(Map<String, dynamic> json) =
      _$TodoEntityImpl.fromJson;

  @override
  bool get complete;

  @override
  String get id;

  @override
  String get task;

  @override
  String get note;

  /// Create a copy of TodoEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodoEntityImplCopyWith<_$TodoEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
