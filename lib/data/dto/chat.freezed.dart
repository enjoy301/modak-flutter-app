// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'chat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Chat _$ChatFromJson(Map<String, dynamic> json) {
  return _Chat.fromJson(json);
}

/// @nodoc
mixin _$Chat {
  int get userId => throw _privateConstructorUsedError;
  set userId(int value) => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  set content(String value) => throw _privateConstructorUsedError;
  double get sendAt => throw _privateConstructorUsedError;
  set sendAt(double value) => throw _privateConstructorUsedError;
  Map<dynamic, dynamic>? get metaData => throw _privateConstructorUsedError;
  set metaData(Map<dynamic, dynamic>? value) =>
      throw _privateConstructorUsedError;
  int get unReadCount => throw _privateConstructorUsedError;
  set unReadCount(int value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatCopyWith<Chat> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatCopyWith<$Res> {
  factory $ChatCopyWith(Chat value, $Res Function(Chat) then) =
      _$ChatCopyWithImpl<$Res>;
  $Res call(
      {int userId,
      String content,
      double sendAt,
      Map<dynamic, dynamic>? metaData,
      int unReadCount});
}

/// @nodoc
class _$ChatCopyWithImpl<$Res> implements $ChatCopyWith<$Res> {
  _$ChatCopyWithImpl(this._value, this._then);

  final Chat _value;
  // ignore: unused_field
  final $Res Function(Chat) _then;

  @override
  $Res call({
    Object? userId = freezed,
    Object? content = freezed,
    Object? sendAt = freezed,
    Object? metaData = freezed,
    Object? unReadCount = freezed,
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
      unReadCount: unReadCount == freezed
          ? _value.unReadCount
          : unReadCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_ChatCopyWith<$Res> implements $ChatCopyWith<$Res> {
  factory _$$_ChatCopyWith(_$_Chat value, $Res Function(_$_Chat) then) =
      __$$_ChatCopyWithImpl<$Res>;
  @override
  $Res call(
      {int userId,
      String content,
      double sendAt,
      Map<dynamic, dynamic>? metaData,
      int unReadCount});
}

/// @nodoc
class __$$_ChatCopyWithImpl<$Res> extends _$ChatCopyWithImpl<$Res>
    implements _$$_ChatCopyWith<$Res> {
  __$$_ChatCopyWithImpl(_$_Chat _value, $Res Function(_$_Chat) _then)
      : super(_value, (v) => _then(v as _$_Chat));

  @override
  _$_Chat get _value => super._value as _$_Chat;

  @override
  $Res call({
    Object? userId = freezed,
    Object? content = freezed,
    Object? sendAt = freezed,
    Object? metaData = freezed,
    Object? unReadCount = freezed,
  }) {
    return _then(_$_Chat(
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
      unReadCount: unReadCount == freezed
          ? _value.unReadCount
          : unReadCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Chat implements _Chat {
  _$_Chat(
      {required this.userId,
      required this.content,
      required this.sendAt,
      required this.metaData,
      required this.unReadCount});

  factory _$_Chat.fromJson(Map<String, dynamic> json) => _$$_ChatFromJson(json);

  @override
  int userId;
  @override
  String content;
  @override
  double sendAt;
  @override
  Map<dynamic, dynamic>? metaData;
  @override
  int unReadCount;

  @override
  String toString() {
    return 'Chat(userId: $userId, content: $content, sendAt: $sendAt, metaData: $metaData, unReadCount: $unReadCount)';
  }

  @JsonKey(ignore: true)
  @override
  _$$_ChatCopyWith<_$_Chat> get copyWith =>
      __$$_ChatCopyWithImpl<_$_Chat>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatToJson(
      this,
    );
  }
}

abstract class _Chat implements Chat {
  factory _Chat(
      {required int userId,
      required String content,
      required double sendAt,
      required Map<dynamic, dynamic>? metaData,
      required int unReadCount}) = _$_Chat;

  factory _Chat.fromJson(Map<String, dynamic> json) = _$_Chat.fromJson;

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
  int get unReadCount;
  set unReadCount(int value);
  @override
  @JsonKey(ignore: true)
  _$$_ChatCopyWith<_$_Chat> get copyWith => throw _privateConstructorUsedError;
}
