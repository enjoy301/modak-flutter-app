// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'letter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Letter _$LetterFromJson(Map<String, dynamic> json) {
  return _Letter.fromJson(json);
}

/// @nodoc
mixin _$Letter {
  @HiveField(0)
  int get fromMemberId => throw _privateConstructorUsedError;
  @HiveField(0)
  set fromMemberId(int value) => throw _privateConstructorUsedError;
  @HiveField(1)
  int get toMemberId => throw _privateConstructorUsedError;
  @HiveField(1)
  set toMemberId(int value) => throw _privateConstructorUsedError;
  @HiveField(2)
  String get content => throw _privateConstructorUsedError;
  @HiveField(2)
  set content(String value) => throw _privateConstructorUsedError;
  @HiveField(3)
  EnvelopeType get envelope => throw _privateConstructorUsedError;
  @HiveField(3)
  set envelope(EnvelopeType value) => throw _privateConstructorUsedError;
  @HiveField(4)
  String get date => throw _privateConstructorUsedError;
  @HiveField(4)
  set date(String value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LetterCopyWith<Letter> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LetterCopyWith<$Res> {
  factory $LetterCopyWith(Letter value, $Res Function(Letter) then) =
      _$LetterCopyWithImpl<$Res>;
  $Res call(
      {@HiveField(0) int fromMemberId,
      @HiveField(1) int toMemberId,
      @HiveField(2) String content,
      @HiveField(3) EnvelopeType envelope,
      @HiveField(4) String date});
}

/// @nodoc
class _$LetterCopyWithImpl<$Res> implements $LetterCopyWith<$Res> {
  _$LetterCopyWithImpl(this._value, this._then);

  final Letter _value;
  // ignore: unused_field
  final $Res Function(Letter) _then;

  @override
  $Res call({
    Object? fromMemberId = freezed,
    Object? toMemberId = freezed,
    Object? content = freezed,
    Object? envelope = freezed,
    Object? date = freezed,
  }) {
    return _then(_value.copyWith(
      fromMemberId: fromMemberId == freezed
          ? _value.fromMemberId
          : fromMemberId // ignore: cast_nullable_to_non_nullable
              as int,
      toMemberId: toMemberId == freezed
          ? _value.toMemberId
          : toMemberId // ignore: cast_nullable_to_non_nullable
              as int,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      envelope: envelope == freezed
          ? _value.envelope
          : envelope // ignore: cast_nullable_to_non_nullable
              as EnvelopeType,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_LetterCopyWith<$Res> implements $LetterCopyWith<$Res> {
  factory _$$_LetterCopyWith(_$_Letter value, $Res Function(_$_Letter) then) =
      __$$_LetterCopyWithImpl<$Res>;
  @override
  $Res call(
      {@HiveField(0) int fromMemberId,
      @HiveField(1) int toMemberId,
      @HiveField(2) String content,
      @HiveField(3) EnvelopeType envelope,
      @HiveField(4) String date});
}

/// @nodoc
class __$$_LetterCopyWithImpl<$Res> extends _$LetterCopyWithImpl<$Res>
    implements _$$_LetterCopyWith<$Res> {
  __$$_LetterCopyWithImpl(_$_Letter _value, $Res Function(_$_Letter) _then)
      : super(_value, (v) => _then(v as _$_Letter));

  @override
  _$_Letter get _value => super._value as _$_Letter;

  @override
  $Res call({
    Object? fromMemberId = freezed,
    Object? toMemberId = freezed,
    Object? content = freezed,
    Object? envelope = freezed,
    Object? date = freezed,
  }) {
    return _then(_$_Letter(
      fromMemberId: fromMemberId == freezed
          ? _value.fromMemberId
          : fromMemberId // ignore: cast_nullable_to_non_nullable
              as int,
      toMemberId: toMemberId == freezed
          ? _value.toMemberId
          : toMemberId // ignore: cast_nullable_to_non_nullable
              as int,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      envelope: envelope == freezed
          ? _value.envelope
          : envelope // ignore: cast_nullable_to_non_nullable
              as EnvelopeType,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 22)
class _$_Letter implements _Letter {
  _$_Letter(
      {@HiveField(0) required this.fromMemberId,
      @HiveField(1) required this.toMemberId,
      @HiveField(2) required this.content,
      @HiveField(3) required this.envelope,
      @HiveField(4) required this.date});

  factory _$_Letter.fromJson(Map<String, dynamic> json) =>
      _$$_LetterFromJson(json);

  @override
  @HiveField(0)
  int fromMemberId;
  @override
  @HiveField(1)
  int toMemberId;
  @override
  @HiveField(2)
  String content;
  @override
  @HiveField(3)
  EnvelopeType envelope;
  @override
  @HiveField(4)
  String date;

  @override
  String toString() {
    return 'Letter(fromMemberId: $fromMemberId, toMemberId: $toMemberId, content: $content, envelope: $envelope, date: $date)';
  }

  @JsonKey(ignore: true)
  @override
  _$$_LetterCopyWith<_$_Letter> get copyWith =>
      __$$_LetterCopyWithImpl<_$_Letter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LetterToJson(
      this,
    );
  }
}

abstract class _Letter implements Letter {
  factory _Letter(
      {@HiveField(0) required int fromMemberId,
      @HiveField(1) required int toMemberId,
      @HiveField(2) required String content,
      @HiveField(3) required EnvelopeType envelope,
      @HiveField(4) required String date}) = _$_Letter;

  factory _Letter.fromJson(Map<String, dynamic> json) = _$_Letter.fromJson;

  @override
  @HiveField(0)
  int get fromMemberId;
  @HiveField(0)
  set fromMemberId(int value);
  @override
  @HiveField(1)
  int get toMemberId;
  @HiveField(1)
  set toMemberId(int value);
  @override
  @HiveField(2)
  String get content;
  @HiveField(2)
  set content(String value);
  @override
  @HiveField(3)
  EnvelopeType get envelope;
  @HiveField(3)
  set envelope(EnvelopeType value);
  @override
  @HiveField(4)
  String get date;
  @HiveField(4)
  set date(String value);
  @override
  @JsonKey(ignore: true)
  _$$_LetterCopyWith<_$_Letter> get copyWith =>
      throw _privateConstructorUsedError;
}
