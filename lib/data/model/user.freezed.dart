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
  String get name => throw _privateConstructorUsedError;
  @HiveField(0)
  set name(String value) => throw _privateConstructorUsedError;
  @HiveField(1)
  String get birthDay => throw _privateConstructorUsedError;
  @HiveField(1)
  set birthDay(String value) => throw _privateConstructorUsedError;
  @HiveField(2)
  bool get isLunar => throw _privateConstructorUsedError;
  @HiveField(2)
  set isLunar(bool value) => throw _privateConstructorUsedError;
  @HiveField(3)
  String get role => throw _privateConstructorUsedError;
  @HiveField(3)
  set role(String value) => throw _privateConstructorUsedError;
  @HiveField(4)
  String get fcmToken => throw _privateConstructorUsedError;
  @HiveField(4)
  set fcmToken(String value) => throw _privateConstructorUsedError;
  @HiveField(5)
  String get color => throw _privateConstructorUsedError;
  @HiveField(5)
  set color(String value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res>;
  $Res call(
      {@HiveField(0) String name,
      @HiveField(1) String birthDay,
      @HiveField(2) bool isLunar,
      @HiveField(3) String role,
      @HiveField(4) String fcmToken,
      @HiveField(5) String color});
}

/// @nodoc
class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  final User _value;
  // ignore: unused_field
  final $Res Function(User) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? birthDay = freezed,
    Object? isLunar = freezed,
    Object? role = freezed,
    Object? fcmToken = freezed,
    Object? color = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      birthDay: birthDay == freezed
          ? _value.birthDay
          : birthDay // ignore: cast_nullable_to_non_nullable
              as String,
      isLunar: isLunar == freezed
          ? _value.isLunar
          : isLunar // ignore: cast_nullable_to_non_nullable
              as bool,
      role: role == freezed
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      fcmToken: fcmToken == freezed
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$_UserCopyWith(_$_User value, $Res Function(_$_User) then) =
      __$$_UserCopyWithImpl<$Res>;
  @override
  $Res call(
      {@HiveField(0) String name,
      @HiveField(1) String birthDay,
      @HiveField(2) bool isLunar,
      @HiveField(3) String role,
      @HiveField(4) String fcmToken,
      @HiveField(5) String color});
}

/// @nodoc
class __$$_UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res>
    implements _$$_UserCopyWith<$Res> {
  __$$_UserCopyWithImpl(_$_User _value, $Res Function(_$_User) _then)
      : super(_value, (v) => _then(v as _$_User));

  @override
  _$_User get _value => super._value as _$_User;

  @override
  $Res call({
    Object? name = freezed,
    Object? birthDay = freezed,
    Object? isLunar = freezed,
    Object? role = freezed,
    Object? fcmToken = freezed,
    Object? color = freezed,
  }) {
    return _then(_$_User(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      birthDay: birthDay == freezed
          ? _value.birthDay
          : birthDay // ignore: cast_nullable_to_non_nullable
              as String,
      isLunar: isLunar == freezed
          ? _value.isLunar
          : isLunar // ignore: cast_nullable_to_non_nullable
              as bool,
      role: role == freezed
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      fcmToken: fcmToken == freezed
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 0)
class _$_User implements _User {
  _$_User(
      {@HiveField(0) required this.name,
      @HiveField(1) required this.birthDay,
      @HiveField(2) required this.isLunar,
      @HiveField(3) required this.role,
      @HiveField(4) required this.fcmToken,
      @HiveField(5) required this.color});

  factory _$_User.fromJson(Map<String, dynamic> json) => _$$_UserFromJson(json);

  @override
  @HiveField(0)
  String name;
  @override
  @HiveField(1)
  String birthDay;
  @override
  @HiveField(2)
  bool isLunar;
  @override
  @HiveField(3)
  String role;
  @override
  @HiveField(4)
  String fcmToken;
  @override
  @HiveField(5)
  String color;

  @override
  String toString() {
    return 'User(name: $name, birthDay: $birthDay, isLunar: $isLunar, role: $role, fcmToken: $fcmToken, color: $color)';
  }

  @JsonKey(ignore: true)
  @override
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
      {@HiveField(0) required String name,
      @HiveField(1) required String birthDay,
      @HiveField(2) required bool isLunar,
      @HiveField(3) required String role,
      @HiveField(4) required String fcmToken,
      @HiveField(5) required String color}) = _$_User;

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  @HiveField(0)
  String get name;
  @HiveField(0)
  set name(String value);
  @override
  @HiveField(1)
  String get birthDay;
  @HiveField(1)
  set birthDay(String value);
  @override
  @HiveField(2)
  bool get isLunar;
  @HiveField(2)
  set isLunar(bool value);
  @override
  @HiveField(3)
  String get role;
  @HiveField(3)
  set role(String value);
  @override
  @HiveField(4)
  String get fcmToken;
  @HiveField(4)
  set fcmToken(String value);
  @override
  @HiveField(5)
  String get color;
  @HiveField(5)
  set color(String value);
  @override
  @JsonKey(ignore: true)
  _$$_UserCopyWith<_$_User> get copyWith => throw _privateConstructorUsedError;
}
