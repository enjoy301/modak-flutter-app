// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'chat_paging_DTO.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChatPagingDTO {
  @HiveField(0)
  int get count => throw _privateConstructorUsedError;
  @HiveField(0)
  set count(int value) => throw _privateConstructorUsedError;
  @HiveField(1)
  int get lastId => throw _privateConstructorUsedError;
  @HiveField(1)
  set lastId(int value) => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatPagingDTOCopyWith<ChatPagingDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatPagingDTOCopyWith<$Res> {
  factory $ChatPagingDTOCopyWith(
          ChatPagingDTO value, $Res Function(ChatPagingDTO) then) =
      _$ChatPagingDTOCopyWithImpl<$Res, ChatPagingDTO>;
  @useResult
  $Res call({@HiveField(0) int count, @HiveField(1) int lastId});
}

/// @nodoc
class _$ChatPagingDTOCopyWithImpl<$Res, $Val extends ChatPagingDTO>
    implements $ChatPagingDTOCopyWith<$Res> {
  _$ChatPagingDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
    Object? lastId = null,
  }) {
    return _then(_value.copyWith(
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      lastId: null == lastId
          ? _value.lastId
          : lastId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChatPagingDTOCopyWith<$Res>
    implements $ChatPagingDTOCopyWith<$Res> {
  factory _$$_ChatPagingDTOCopyWith(
          _$_ChatPagingDTO value, $Res Function(_$_ChatPagingDTO) then) =
      __$$_ChatPagingDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@HiveField(0) int count, @HiveField(1) int lastId});
}

/// @nodoc
class __$$_ChatPagingDTOCopyWithImpl<$Res>
    extends _$ChatPagingDTOCopyWithImpl<$Res, _$_ChatPagingDTO>
    implements _$$_ChatPagingDTOCopyWith<$Res> {
  __$$_ChatPagingDTOCopyWithImpl(
      _$_ChatPagingDTO _value, $Res Function(_$_ChatPagingDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
    Object? lastId = null,
  }) {
    return _then(_$_ChatPagingDTO(
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      lastId: null == lastId
          ? _value.lastId
          : lastId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 30)
class _$_ChatPagingDTO implements _ChatPagingDTO {
  _$_ChatPagingDTO(
      {@HiveField(0) required this.count, @HiveField(1) required this.lastId});

  @override
  @HiveField(0)
  int count;
  @override
  @HiveField(1)
  int lastId;

  @override
  String toString() {
    return 'ChatPagingDTO(count: $count, lastId: $lastId)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatPagingDTOCopyWith<_$_ChatPagingDTO> get copyWith =>
      __$$_ChatPagingDTOCopyWithImpl<_$_ChatPagingDTO>(this, _$identity);
}

abstract class _ChatPagingDTO implements ChatPagingDTO {
  factory _ChatPagingDTO(
      {@HiveField(0) required int count,
      @HiveField(1) required int lastId}) = _$_ChatPagingDTO;

  @override
  @HiveField(0)
  int get count;
  @HiveField(0)
  set count(int value);
  @override
  @HiveField(1)
  int get lastId;
  @HiveField(1)
  set lastId(int value);
  @override
  @JsonKey(ignore: true)
  _$$_ChatPagingDTOCopyWith<_$_ChatPagingDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
