// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'today_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TodayContent _$TodayContentFromJson(Map<String, dynamic> json) {
  return _TodayContent.fromJson(json);
}

/// @nodoc
mixin _$TodayContent {
  @HiveField(0)
  int get id => throw _privateConstructorUsedError;
  @HiveField(0)
  set id(int value) => throw _privateConstructorUsedError;
  @HiveField(1)
  String get type => throw _privateConstructorUsedError;
  @HiveField(1)
  set type(String value) => throw _privateConstructorUsedError;
  @HiveField(2)
  String get title => throw _privateConstructorUsedError;
  @HiveField(2)
  set title(String value) => throw _privateConstructorUsedError;
  @HiveField(3)
  String get desc => throw _privateConstructorUsedError;
  @HiveField(3)
  set desc(String value) => throw _privateConstructorUsedError;
  @HiveField(4)
  String get url => throw _privateConstructorUsedError;
  @HiveField(4)
  set url(String value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodayContentCopyWith<TodayContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodayContentCopyWith<$Res> {
  factory $TodayContentCopyWith(
          TodayContent value, $Res Function(TodayContent) then) =
      _$TodayContentCopyWithImpl<$Res>;
  $Res call(
      {@HiveField(0) int id,
      @HiveField(1) String type,
      @HiveField(2) String title,
      @HiveField(3) String desc,
      @HiveField(4) String url});
}

/// @nodoc
class _$TodayContentCopyWithImpl<$Res> implements $TodayContentCopyWith<$Res> {
  _$TodayContentCopyWithImpl(this._value, this._then);

  final TodayContent _value;
  // ignore: unused_field
  final $Res Function(TodayContent) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? title = freezed,
    Object? desc = freezed,
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      desc: desc == freezed
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_TodayContentCopyWith<$Res>
    implements $TodayContentCopyWith<$Res> {
  factory _$$_TodayContentCopyWith(
          _$_TodayContent value, $Res Function(_$_TodayContent) then) =
      __$$_TodayContentCopyWithImpl<$Res>;
  @override
  $Res call(
      {@HiveField(0) int id,
      @HiveField(1) String type,
      @HiveField(2) String title,
      @HiveField(3) String desc,
      @HiveField(4) String url});
}

/// @nodoc
class __$$_TodayContentCopyWithImpl<$Res>
    extends _$TodayContentCopyWithImpl<$Res>
    implements _$$_TodayContentCopyWith<$Res> {
  __$$_TodayContentCopyWithImpl(
      _$_TodayContent _value, $Res Function(_$_TodayContent) _then)
      : super(_value, (v) => _then(v as _$_TodayContent));

  @override
  _$_TodayContent get _value => super._value as _$_TodayContent;

  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? title = freezed,
    Object? desc = freezed,
    Object? url = freezed,
  }) {
    return _then(_$_TodayContent(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      desc: desc == freezed
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 50)
class _$_TodayContent implements _TodayContent {
  _$_TodayContent(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.type,
      @HiveField(2) required this.title,
      @HiveField(3) required this.desc,
      @HiveField(4) required this.url});

  factory _$_TodayContent.fromJson(Map<String, dynamic> json) =>
      _$$_TodayContentFromJson(json);

  @override
  @HiveField(0)
  int id;
  @override
  @HiveField(1)
  String type;
  @override
  @HiveField(2)
  String title;
  @override
  @HiveField(3)
  String desc;
  @override
  @HiveField(4)
  String url;

  @override
  String toString() {
    return 'TodayContent(id: $id, type: $type, title: $title, desc: $desc, url: $url)';
  }

  @JsonKey(ignore: true)
  @override
  _$$_TodayContentCopyWith<_$_TodayContent> get copyWith =>
      __$$_TodayContentCopyWithImpl<_$_TodayContent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TodayContentToJson(
      this,
    );
  }
}

abstract class _TodayContent implements TodayContent {
  factory _TodayContent(
      {@HiveField(0) required int id,
      @HiveField(1) required String type,
      @HiveField(2) required String title,
      @HiveField(3) required String desc,
      @HiveField(4) required String url}) = _$_TodayContent;

  factory _TodayContent.fromJson(Map<String, dynamic> json) =
      _$_TodayContent.fromJson;

  @override
  @HiveField(0)
  int get id;
  @HiveField(0)
  set id(int value);
  @override
  @HiveField(1)
  String get type;
  @HiveField(1)
  set type(String value);
  @override
  @HiveField(2)
  String get title;
  @HiveField(2)
  set title(String value);
  @override
  @HiveField(3)
  String get desc;
  @HiveField(3)
  set desc(String value);
  @override
  @HiveField(4)
  String get url;
  @HiveField(4)
  set url(String value);
  @override
  @JsonKey(ignore: true)
  _$$_TodayContentCopyWith<_$_TodayContent> get copyWith =>
      throw _privateConstructorUsedError;
}
