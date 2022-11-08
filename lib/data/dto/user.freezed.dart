// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  @HiveField(0)
  int get memberId => throw _privateConstructorUsedError;
  @HiveField(0)
  set memberId(int value) => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(1)
  set name(String value) => throw _privateConstructorUsedError;
  @HiveField(2)
  String get birthDay => throw _privateConstructorUsedError;
  @HiveField(2)
  set birthDay(String value) => throw _privateConstructorUsedError;
  @HiveField(3)
  bool get isLunar => throw _privateConstructorUsedError;
  @HiveField(3)
  set isLunar(bool value) => throw _privateConstructorUsedError;
  @HiveField(4)
  String get role => throw _privateConstructorUsedError;
  @HiveField(4)
  set role(String value) => throw _privateConstructorUsedError;
  @HiveField(5)
  String get fcmToken => throw _privateConstructorUsedError;
  @HiveField(5)
  set fcmToken(String value) => throw _privateConstructorUsedError;
  @HiveField(6)
  String get color => throw _privateConstructorUsedError;
  @HiveField(6)
  set color(String value) => throw _privateConstructorUsedError;
  @HiveField(7)
  List<String> get timeTags => throw _privateConstructorUsedError;
  @HiveField(7)
  set timeTags(List<String> value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {@HiveField(0) int memberId,
      @HiveField(1) String name,
      @HiveField(2) String birthDay,
      @HiveField(3) bool isLunar,
      @HiveField(4) String role,
      @HiveField(5) String fcmToken,
      @HiveField(6) String color,
      @HiveField(7) List<String> timeTags});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberId = null,
    Object? name = null,
    Object? birthDay = null,
    Object? isLunar = null,
    Object? role = null,
    Object? fcmToken = null,
    Object? color = null,
    Object? timeTags = null,
  }) {
    return _then(_value.copyWith(
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      birthDay: null == birthDay
          ? _value.birthDay
          : birthDay // ignore: cast_nullable_to_non_nullable
              as String,
      isLunar: null == isLunar
          ? _value.isLunar
          : isLunar // ignore: cast_nullable_to_non_nullable
              as bool,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      fcmToken: null == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      timeTags: null == timeTags
          ? _value.timeTags
          : timeTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$_UserCopyWith(_$_User value, $Res Function(_$_User) then) =
      __$$_UserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) int memberId,
      @HiveField(1) String name,
      @HiveField(2) String birthDay,
      @HiveField(3) bool isLunar,
      @HiveField(4) String role,
      @HiveField(5) String fcmToken,
      @HiveField(6) String color,
      @HiveField(7) List<String> timeTags});
}

/// @nodoc
class __$$_UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res, _$_User>
    implements _$$_UserCopyWith<$Res> {
  __$$_UserCopyWithImpl(_$_User _value, $Res Function(_$_User) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberId = null,
    Object? name = null,
    Object? birthDay = null,
    Object? isLunar = null,
    Object? role = null,
    Object? fcmToken = null,
    Object? color = null,
    Object? timeTags = null,
  }) {
    return _then(_$_User(
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      birthDay: null == birthDay
          ? _value.birthDay
          : birthDay // ignore: cast_nullable_to_non_nullable
              as String,
      isLunar: null == isLunar
          ? _value.isLunar
          : isLunar // ignore: cast_nullable_to_non_nullable
              as bool,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      fcmToken: null == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      timeTags: null == timeTags
          ? _value.timeTags
          : timeTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 0)
class _$_User implements _User {
  _$_User(
      {@HiveField(0) required this.memberId,
      @HiveField(1) required this.name,
      @HiveField(2) required this.birthDay,
      @HiveField(3) required this.isLunar,
      @HiveField(4) required this.role,
      @HiveField(5) required this.fcmToken,
      @HiveField(6) required this.color,
      @HiveField(7) required this.timeTags});

  factory _$_User.fromJson(Map<String, dynamic> json) => _$$_UserFromJson(json);

  @override
  @HiveField(0)
  int memberId;
  @override
  @HiveField(1)
  String name;
  @override
  @HiveField(2)
  String birthDay;
  @override
  @HiveField(3)
  bool isLunar;
  @override
  @HiveField(4)
  String role;
  @override
  @HiveField(5)
  String fcmToken;
  @override
  @HiveField(6)
  String color;
  @override
  @HiveField(7)
  List<String> timeTags;

  @override
  String toString() {
    return 'User(memberId: $memberId, name: $name, birthDay: $birthDay, isLunar: $isLunar, role: $role, fcmToken: $fcmToken, color: $color, timeTags: $timeTags)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserCopyWith<_$_User> get copyWith =>
      __$$_UserCopyWithImpl<_$_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserToJson(
      this,
    );
  }
}

abstract class _User implements User {
  factory _User(
      {@HiveField(0) required int memberId,
      @HiveField(1) required String name,
      @HiveField(2) required String birthDay,
      @HiveField(3) required bool isLunar,
      @HiveField(4) required String role,
      @HiveField(5) required String fcmToken,
      @HiveField(6) required String color,
      @HiveField(7) required List<String> timeTags}) = _$_User;

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  @HiveField(0)
  int get memberId;
  @HiveField(0)
  set memberId(int value);
  @override
  @HiveField(1)
  String get name;
  @HiveField(1)
  set name(String value);
  @override
  @HiveField(2)
  String get birthDay;
  @HiveField(2)
  set birthDay(String value);
  @override
  @HiveField(3)
  bool get isLunar;
  @HiveField(3)
  set isLunar(bool value);
  @override
  @HiveField(4)
  String get role;
  @HiveField(4)
  set role(String value);
  @override
  @HiveField(5)
  String get fcmToken;
  @HiveField(5)
  set fcmToken(String value);
  @override
  @HiveField(6)
  String get color;
  @HiveField(6)
  set color(String value);
  @override
  @HiveField(7)
  List<String> get timeTags;
  @HiveField(7)
  set timeTags(List<String> value);
  @override
  @JsonKey(ignore: true)
  _$$_UserCopyWith<_$_User> get copyWith => throw _privateConstructorUsedError;
}
