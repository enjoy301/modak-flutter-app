// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Noti _$NotiFromJson(Map<String, dynamic> json) {
  return _Noti.fromJson(json);
}

/// @nodoc
mixin _$Noti {
  @HiveField(0)
  String get notiType => throw _privateConstructorUsedError;
  @HiveField(0)
  set notiType(String value) => throw _privateConstructorUsedError;
  @HiveField(1)
  String get title => throw _privateConstructorUsedError;
  @HiveField(1)
  set title(String value) => throw _privateConstructorUsedError;
  @HiveField(2)
  String get des => throw _privateConstructorUsedError;
  @HiveField(2)
  set des(String value) => throw _privateConstructorUsedError;
  @HiveField(3)
  bool get isRead => throw _privateConstructorUsedError;
  @HiveField(3)
  set isRead(bool value) => throw _privateConstructorUsedError;
  @HiveField(4)
  Map<dynamic, dynamic> get metaData => throw _privateConstructorUsedError;
  @HiveField(4)
  set metaData(Map<dynamic, dynamic> value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotiCopyWith<Noti> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotiCopyWith<$Res> {
  factory $NotiCopyWith(Noti value, $Res Function(Noti) then) =
      _$NotiCopyWithImpl<$Res>;
  $Res call(
      {@HiveField(0) String notiType,
      @HiveField(1) String title,
      @HiveField(2) String des,
      @HiveField(3) bool isRead,
      @HiveField(4) Map<dynamic, dynamic> metaData});
}

/// @nodoc
class _$NotiCopyWithImpl<$Res> implements $NotiCopyWith<$Res> {
  _$NotiCopyWithImpl(this._value, this._then);

  final Noti _value;
  // ignore: unused_field
  final $Res Function(Noti) _then;

  @override
  $Res call({
    Object? notiType = freezed,
    Object? title = freezed,
    Object? des = freezed,
    Object? isRead = freezed,
    Object? metaData = freezed,
  }) {
    return _then(_value.copyWith(
      notiType: notiType == freezed
          ? _value.notiType
          : notiType // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      des: des == freezed
          ? _value.des
          : des // ignore: cast_nullable_to_non_nullable
              as String,
      isRead: isRead == freezed
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      metaData: metaData == freezed
          ? _value.metaData
          : metaData // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>,
    ));
  }
}

/// @nodoc
abstract class _$$_NotiCopyWith<$Res> implements $NotiCopyWith<$Res> {
  factory _$$_NotiCopyWith(_$_Noti value, $Res Function(_$_Noti) then) =
      __$$_NotiCopyWithImpl<$Res>;
  @override
  $Res call(
      {@HiveField(0) String notiType,
      @HiveField(1) String title,
      @HiveField(2) String des,
      @HiveField(3) bool isRead,
      @HiveField(4) Map<dynamic, dynamic> metaData});
}

/// @nodoc
class __$$_NotiCopyWithImpl<$Res> extends _$NotiCopyWithImpl<$Res>
    implements _$$_NotiCopyWith<$Res> {
  __$$_NotiCopyWithImpl(_$_Noti _value, $Res Function(_$_Noti) _then)
      : super(_value, (v) => _then(v as _$_Noti));

  @override
  _$_Noti get _value => super._value as _$_Noti;

  @override
  $Res call({
    Object? notiType = freezed,
    Object? title = freezed,
    Object? des = freezed,
    Object? isRead = freezed,
    Object? metaData = freezed,
  }) {
    return _then(_$_Noti(
      notiType: notiType == freezed
          ? _value.notiType
          : notiType // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      des: des == freezed
          ? _value.des
          : des // ignore: cast_nullable_to_non_nullable
              as String,
      isRead: isRead == freezed
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      metaData: metaData == freezed
          ? _value.metaData
          : metaData // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 32)
class _$_Noti implements _Noti {
  _$_Noti(
      {@HiveField(0) required this.notiType,
      @HiveField(1) required this.title,
      @HiveField(2) required this.des,
      @HiveField(3) required this.isRead,
      @HiveField(4) required this.metaData});

  factory _$_Noti.fromJson(Map<String, dynamic> json) => _$$_NotiFromJson(json);

  @override
  @HiveField(0)
  String notiType;
  @override
  @HiveField(1)
  String title;
  @override
  @HiveField(2)
  String des;
  @override
  @HiveField(3)
  bool isRead;
  @override
  @HiveField(4)
  Map<dynamic, dynamic> metaData;

  @override
  String toString() {
    return 'Noti(notiType: $notiType, title: $title, des: $des, isRead: $isRead, metaData: $metaData)';
  }

  @JsonKey(ignore: true)
  @override
  _$$_NotiCopyWith<_$_Noti> get copyWith =>
      __$$_NotiCopyWithImpl<_$_Noti>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NotiToJson(
      this,
    );
  }
}

abstract class _Noti implements Noti {
  factory _Noti(
      {@HiveField(0) required String notiType,
      @HiveField(1) required String title,
      @HiveField(2) required String des,
      @HiveField(3) required bool isRead,
      @HiveField(4) required Map<dynamic, dynamic> metaData}) = _$_Noti;

  factory _Noti.fromJson(Map<String, dynamic> json) = _$_Noti.fromJson;

  @override
  @HiveField(0)
  String get notiType;
  @HiveField(0)
  set notiType(String value);
  @override
  @HiveField(1)
  String get title;
  @HiveField(1)
  set title(String value);
  @override
  @HiveField(2)
  String get des;
  @HiveField(2)
  set des(String value);
  @override
  @HiveField(3)
  bool get isRead;
  @HiveField(3)
  set isRead(bool value);
  @override
  @HiveField(4)
  Map<dynamic, dynamic> get metaData;
  @HiveField(4)
  set metaData(Map<dynamic, dynamic> value);
  @override
  @JsonKey(ignore: true)
  _$$_NotiCopyWith<_$_Noti> get copyWith => throw _privateConstructorUsedError;
}
