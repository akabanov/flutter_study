// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezed_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FreezedEntity _$FreezedEntityFromJson(Map<String, dynamic> json) {
  return _FreezedEntity.fromJson(json);
}

/// @nodoc
mixin _$FreezedEntity {
  String get id => throw _privateConstructorUsedError;

  /// Serializes this FreezedEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FreezedEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FreezedEntityCopyWith<FreezedEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FreezedEntityCopyWith<$Res> {
  factory $FreezedEntityCopyWith(
          FreezedEntity value, $Res Function(FreezedEntity) then) =
      _$FreezedEntityCopyWithImpl<$Res, FreezedEntity>;

  @useResult
  $Res call({String id});
}

/// @nodoc
class _$FreezedEntityCopyWithImpl<$Res, $Val extends FreezedEntity>
    implements $FreezedEntityCopyWith<$Res> {
  _$FreezedEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;

  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FreezedEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FreezedEntityImplCopyWith<$Res>
    implements $FreezedEntityCopyWith<$Res> {
  factory _$$FreezedEntityImplCopyWith(
          _$FreezedEntityImpl value, $Res Function(_$FreezedEntityImpl) then) =
      __$$FreezedEntityImplCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$FreezedEntityImplCopyWithImpl<$Res>
    extends _$FreezedEntityCopyWithImpl<$Res, _$FreezedEntityImpl>
    implements _$$FreezedEntityImplCopyWith<$Res> {
  __$$FreezedEntityImplCopyWithImpl(
      _$FreezedEntityImpl _value, $Res Function(_$FreezedEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of FreezedEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$FreezedEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FreezedEntityImpl
    with DiagnosticableTreeMixin
    implements _FreezedEntity {
  const _$FreezedEntityImpl({required this.id});

  factory _$FreezedEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$FreezedEntityImplFromJson(json);

  @override
  final String id;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FreezedEntity(id: $id)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FreezedEntity'))
      ..add(DiagnosticsProperty('id', id));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FreezedEntityImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of FreezedEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FreezedEntityImplCopyWith<_$FreezedEntityImpl> get copyWith =>
      __$$FreezedEntityImplCopyWithImpl<_$FreezedEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FreezedEntityImplToJson(
      this,
    );
  }
}

abstract class _FreezedEntity implements FreezedEntity {
  const factory _FreezedEntity({required final String id}) =
      _$FreezedEntityImpl;

  factory _FreezedEntity.fromJson(Map<String, dynamic> json) =
      _$FreezedEntityImpl.fromJson;

  @override
  String get id;

  /// Create a copy of FreezedEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FreezedEntityImplCopyWith<_$FreezedEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
