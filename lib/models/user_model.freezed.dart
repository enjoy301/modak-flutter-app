// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String? get name => throw _privateConstructorUsedError;
  String? get birthDay => throw _privateConstructorUsedError;
  bool? get isLunar => throw _privateConstructorUsedError;
  FamilyType? get role => throw _privateConstructorUsedError;
  String? get fcmToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res>;
  $Res call(
      {String? name,
      String? birthDay,
      bool? isLunar,
      FamilyType? role,
      String? fcmToken});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res> implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  final UserModel _value;
  // ignore: unused_field
  final $Res Function(UserModel) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? birthDay = freezed,
    Object? isLunar = freezed,
    Object? role = freezed,
    Object? fcmToken = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      birthDay: birthDay == freezed
          ? _value.birthDay
          : birthDay // ignore: cast_nullable_to_non_nullable
              as String?,
      isLunar: isLunar == freezed
          ? _value.isLunar
          : isLunar // ignore: cast_nullable_to_non_nullable
              as bool?,
      role: role == freezed
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as FamilyType?,
      fcmToken: fcmToken == freezed
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$$_UserModelCopyWith(
          _$_UserModel value, $Res Function(_$_UserModel) then) =
      __$$_UserModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? name,
      String? birthDay,
      bool? isLunar,
      FamilyType? role,
      String? fcmToken});
}

/// @nodoc
class __$$_UserModelCopyWithImpl<$Res> extends _$UserModelCopyWithImpl<$Res>
    implements _$$_UserModelCopyWith<$Res> {
  __$$_UserModelCopyWithImpl(
      _$_UserModel _value, $Res Function(_$_UserModel) _then)
      : super(_value, (v) => _then(v as _$_UserModel));

  @override
  _$_UserModel get _value => super._value as _$_UserModel;

  @override
  $Res call({
    Object? name = freezed,
    Object? birthDay = freezed,
    Object? isLunar = freezed,
    Object? role = freezed,
    Object? fcmToken = freezed,
  }) {
    return _then(_$_UserModel(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      birthDay: birthDay == freezed
          ? _value.birthDay
          : birthDay // ignore: cast_nullable_to_non_nullable
              as String?,
      isLunar: isLunar == freezed
          ? _value.isLunar
          : isLunar // ignore: cast_nullable_to_non_nullable
              as bool?,
      role: role == freezed
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as FamilyType?,
      fcmToken: fcmToken == freezed
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserModel implements _UserModel {
  _$_UserModel(
      {required this.name,
      required this.birthDay,
      required this.isLunar,
      required this.role,
      required this.fcmToken});

  factory _$_UserModel.fromJson(Map<String, dynamic> json) =>
      _$$_UserModelFromJson(json);

  @override
  final String? name;
  @override
  final String? birthDay;
  @override
  final bool? isLunar;
  @override
  final FamilyType? role;
  @override
  final String? fcmToken;

  @override
  String toString() {
    return 'UserModel(name: $name, birthDay: $birthDay, isLunar: $isLunar, role: $role, fcmToken: $fcmToken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserModel &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.birthDay, birthDay) &&
            const DeepCollectionEquality().equals(other.isLunar, isLunar) &&
            const DeepCollectionEquality().equals(other.role, role) &&
            const DeepCollectionEquality().equals(other.fcmToken, fcmToken));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(birthDay),
      const DeepCollectionEquality().hash(isLunar),
      const DeepCollectionEquality().hash(role),
      const DeepCollectionEquality().hash(fcmToken));

  @JsonKey(ignore: true)
  @override
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      __$$_UserModelCopyWithImpl<_$_UserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserModelToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  factory _UserModel(
      {required final String? name,
      required final String? birthDay,
      required final bool? isLunar,
      required final FamilyType? role,
      required final String? fcmToken}) = _$_UserModel;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$_UserModel.fromJson;

  @override
  String? get name;
  @override
  String? get birthDay;
  @override
  bool? get isLunar;
  @override
  FamilyType? get role;
  @override
  String? get fcmToken;
  @override
  @JsonKey(ignore: true)
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}
