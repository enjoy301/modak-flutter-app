// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'fortune.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Fortune _$FortuneFromJson(Map<String, dynamic> json) {
  return _Fortune.fromJson(json);
}

/// @nodoc
mixin _$Fortune {
  String get type => throw _privateConstructorUsedError;
  set type(String value) => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  set content(String value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FortuneCopyWith<Fortune> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FortuneCopyWith<$Res> {
  factory $FortuneCopyWith(Fortune value, $Res Function(Fortune) then) =
      _$FortuneCopyWithImpl<$Res>;
  $Res call({String type, String content});
}

/// @nodoc
class _$FortuneCopyWithImpl<$Res> implements $FortuneCopyWith<$Res> {
  _$FortuneCopyWithImpl(this._value, this._then);

  final Fortune _value;
  // ignore: unused_field
  final $Res Function(Fortune) _then;

  @override
  $Res call({
    Object? type = freezed,
    Object? content = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_FortuneCopyWith<$Res> implements $FortuneCopyWith<$Res> {
  factory _$$_FortuneCopyWith(
          _$_Fortune value, $Res Function(_$_Fortune) then) =
      __$$_FortuneCopyWithImpl<$Res>;
  @override
  $Res call({String type, String content});
}

/// @nodoc
class __$$_FortuneCopyWithImpl<$Res> extends _$FortuneCopyWithImpl<$Res>
    implements _$$_FortuneCopyWith<$Res> {
  __$$_FortuneCopyWithImpl(_$_Fortune _value, $Res Function(_$_Fortune) _then)
      : super(_value, (v) => _then(v as _$_Fortune));

  @override
  _$_Fortune get _value => super._value as _$_Fortune;

  @override
  $Res call({
    Object? type = freezed,
    Object? content = freezed,
  }) {
    return _then(_$_Fortune(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Fortune implements _Fortune {
  _$_Fortune({required this.type, required this.content});

  factory _$_Fortune.fromJson(Map<String, dynamic> json) =>
      _$$_FortuneFromJson(json);

  @override
  String type;
  @override
  String content;

  @override
  String toString() {
    return 'Fortune(type: $type, content: $content)';
  }

  @JsonKey(ignore: true)
  @override
  _$$_FortuneCopyWith<_$_Fortune> get copyWith =>
      __$$_FortuneCopyWithImpl<_$_Fortune>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FortuneToJson(
      this,
    );
  }
}

abstract class _Fortune implements Fortune {
  factory _Fortune({required String type, required String content}) =
      _$_Fortune;

  factory _Fortune.fromJson(Map<String, dynamic> json) = _$_Fortune.fromJson;

  @override
  String get type;
  set type(String value);
  @override
  String get content;
  set content(String value);
  @override
  @JsonKey(ignore: true)
  _$$_FortuneCopyWith<_$_Fortune> get copyWith =>
      throw _privateConstructorUsedError;
}
