// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'chat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) {
  return _ChatModel.fromJson(json);
}

/// @nodoc
mixin _$ChatModel {
  int get userId => throw _privateConstructorUsedError;
  set userId(int value) => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  set content(String value) => throw _privateConstructorUsedError;
  double get sendAt => throw _privateConstructorUsedError;
  set sendAt(double value) => throw _privateConstructorUsedError;
  Map<dynamic, dynamic>? get metaData => throw _privateConstructorUsedError;
  set metaData(Map<dynamic, dynamic>? value) =>
      throw _privateConstructorUsedError;
  int get readCount => throw _privateConstructorUsedError;
  set readCount(int value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatModelCopyWith<ChatModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatModelCopyWith<$Res> {
  factory $ChatModelCopyWith(ChatModel value, $Res Function(ChatModel) then) =
      _$ChatModelCopyWithImpl<$Res>;
  $Res call(
      {int userId,
      String content,
      double sendAt,
      Map<dynamic, dynamic>? metaData,
      int readCount});
}

/// @nodoc
class _$ChatModelCopyWithImpl<$Res> implements $ChatModelCopyWith<$Res> {
  _$ChatModelCopyWithImpl(this._value, this._then);

  final ChatModel _value;
  // ignore: unused_field
  final $Res Function(ChatModel) _then;

  @override
  $Res call({
    Object? userId = freezed,
    Object? content = freezed,
    Object? sendAt = freezed,
    Object? metaData = freezed,
    Object? readCount = freezed,
  }) {
    return _then(_value.copyWith(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      sendAt: sendAt == freezed
          ? _value.sendAt
          : sendAt // ignore: cast_nullable_to_non_nullable
              as double,
      metaData: metaData == freezed
          ? _value.metaData
          : metaData // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>?,
      readCount: readCount == freezed
          ? _value.readCount
          : readCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_ChatModelCopyWith<$Res> implements $ChatModelCopyWith<$Res> {
  factory _$$_ChatModelCopyWith(
          _$_ChatModel value, $Res Function(_$_ChatModel) then) =
      __$$_ChatModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int userId,
      String content,
      double sendAt,
      Map<dynamic, dynamic>? metaData,
      int readCount});
}

/// @nodoc
class __$$_ChatModelCopyWithImpl<$Res> extends _$ChatModelCopyWithImpl<$Res>
    implements _$$_ChatModelCopyWith<$Res> {
  __$$_ChatModelCopyWithImpl(
      _$_ChatModel _value, $Res Function(_$_ChatModel) _then)
      : super(_value, (v) => _then(v as _$_ChatModel));

  @override
  _$_ChatModel get _value => super._value as _$_ChatModel;

  @override
  $Res call({
    Object? userId = freezed,
    Object? content = freezed,
    Object? sendAt = freezed,
    Object? metaData = freezed,
    Object? readCount = freezed,
  }) {
    return _then(_$_ChatModel(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      sendAt: sendAt == freezed
          ? _value.sendAt
          : sendAt // ignore: cast_nullable_to_non_nullable
              as double,
      metaData: metaData == freezed
          ? _value.metaData
          : metaData // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>?,
      readCount: readCount == freezed
          ? _value.readCount
          : readCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChatModel implements _ChatModel {
  _$_ChatModel(
      {required this.userId,
      required this.content,
      required this.sendAt,
      required this.metaData,
      required this.readCount});

  factory _$_ChatModel.fromJson(Map<String, dynamic> json) =>
      _$$_ChatModelFromJson(json);

  @override
  int userId;
  @override
  String content;
  @override
  double sendAt;
  @override
  Map<dynamic, dynamic>? metaData;
  @override
  int readCount;

  @override
  String toString() {
    return 'ChatModel(userId: $userId, content: $content, sendAt: $sendAt, metaData: $metaData, readCount: $readCount)';
  }

  @JsonKey(ignore: true)
  @override
  _$$_ChatModelCopyWith<_$_ChatModel> get copyWith =>
      __$$_ChatModelCopyWithImpl<_$_ChatModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatModelToJson(
      this,
    );
  }
}

abstract class _ChatModel implements ChatModel {
  factory _ChatModel(
      {required int userId,
      required String content,
      required double sendAt,
      required Map<dynamic, dynamic>? metaData,
      required int readCount}) = _$_ChatModel;

  factory _ChatModel.fromJson(Map<String, dynamic> json) =
      _$_ChatModel.fromJson;

  @override
  int get userId;
  set userId(int value);
  @override
  String get content;
  set content(String value);
  @override
  double get sendAt;
  set sendAt(double value);
  @override
  Map<dynamic, dynamic>? get metaData;
  set metaData(Map<dynamic, dynamic>? value);
  @override
  int get readCount;
  set readCount(int value);
  @override
  @JsonKey(ignore: true)
  _$$_ChatModelCopyWith<_$_ChatModel> get copyWith =>
      throw _privateConstructorUsedError;
}
