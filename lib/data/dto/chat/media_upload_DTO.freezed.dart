// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'media_upload_DTO.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MediaUploadDTO {
  @HiveField(0)
  Map<String, dynamic> get mediaUrlData => throw _privateConstructorUsedError;
  @HiveField(0)
  set mediaUrlData(Map<String, dynamic> value) =>
      throw _privateConstructorUsedError;
  @HiveField(1)
  MultipartFile get file => throw _privateConstructorUsedError;
  @HiveField(1)
  set file(MultipartFile value) => throw _privateConstructorUsedError;
  @HiveField(2)
  String get type => throw _privateConstructorUsedError;
  @HiveField(2)
  set type(String value) => throw _privateConstructorUsedError;
  @HiveField(3)
  int get imageCount => throw _privateConstructorUsedError;
  @HiveField(3)
  set imageCount(int value) => throw _privateConstructorUsedError;
  @HiveField(4)
  String get memberId => throw _privateConstructorUsedError;
  @HiveField(4)
  set memberId(String value) => throw _privateConstructorUsedError;
  @HiveField(5)
  String get familyId => throw _privateConstructorUsedError;
  @HiveField(5)
  set familyId(String value) => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MediaUploadDTOCopyWith<MediaUploadDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaUploadDTOCopyWith<$Res> {
  factory $MediaUploadDTOCopyWith(
          MediaUploadDTO value, $Res Function(MediaUploadDTO) then) =
      _$MediaUploadDTOCopyWithImpl<$Res, MediaUploadDTO>;
  @useResult
  $Res call(
      {@HiveField(0) Map<String, dynamic> mediaUrlData,
      @HiveField(1) MultipartFile file,
      @HiveField(2) String type,
      @HiveField(3) int imageCount,
      @HiveField(4) String memberId,
      @HiveField(5) String familyId});
}

/// @nodoc
class _$MediaUploadDTOCopyWithImpl<$Res, $Val extends MediaUploadDTO>
    implements $MediaUploadDTOCopyWith<$Res> {
  _$MediaUploadDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mediaUrlData = null,
    Object? file = null,
    Object? type = null,
    Object? imageCount = null,
    Object? memberId = null,
    Object? familyId = null,
  }) {
    return _then(_value.copyWith(
      mediaUrlData: null == mediaUrlData
          ? _value.mediaUrlData
          : mediaUrlData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      file: null == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as MultipartFile,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      imageCount: null == imageCount
          ? _value.imageCount
          : imageCount // ignore: cast_nullable_to_non_nullable
              as int,
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String,
      familyId: null == familyId
          ? _value.familyId
          : familyId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MediaUploadDTOCopyWith<$Res>
    implements $MediaUploadDTOCopyWith<$Res> {
  factory _$$_MediaUploadDTOCopyWith(
          _$_MediaUploadDTO value, $Res Function(_$_MediaUploadDTO) then) =
      __$$_MediaUploadDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) Map<String, dynamic> mediaUrlData,
      @HiveField(1) MultipartFile file,
      @HiveField(2) String type,
      @HiveField(3) int imageCount,
      @HiveField(4) String memberId,
      @HiveField(5) String familyId});
}

/// @nodoc
class __$$_MediaUploadDTOCopyWithImpl<$Res>
    extends _$MediaUploadDTOCopyWithImpl<$Res, _$_MediaUploadDTO>
    implements _$$_MediaUploadDTOCopyWith<$Res> {
  __$$_MediaUploadDTOCopyWithImpl(
      _$_MediaUploadDTO _value, $Res Function(_$_MediaUploadDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mediaUrlData = null,
    Object? file = null,
    Object? type = null,
    Object? imageCount = null,
    Object? memberId = null,
    Object? familyId = null,
  }) {
    return _then(_$_MediaUploadDTO(
      mediaUrlData: null == mediaUrlData
          ? _value.mediaUrlData
          : mediaUrlData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      file: null == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as MultipartFile,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      imageCount: null == imageCount
          ? _value.imageCount
          : imageCount // ignore: cast_nullable_to_non_nullable
              as int,
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String,
      familyId: null == familyId
          ? _value.familyId
          : familyId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 31)
class _$_MediaUploadDTO implements _MediaUploadDTO {
  _$_MediaUploadDTO(
      {@HiveField(0) required this.mediaUrlData,
      @HiveField(1) required this.file,
      @HiveField(2) required this.type,
      @HiveField(3) required this.imageCount,
      @HiveField(4) required this.memberId,
      @HiveField(5) required this.familyId});

  @override
  @HiveField(0)
  Map<String, dynamic> mediaUrlData;
  @override
  @HiveField(1)
  MultipartFile file;
  @override
  @HiveField(2)
  String type;
  @override
  @HiveField(3)
  int imageCount;
  @override
  @HiveField(4)
  String memberId;
  @override
  @HiveField(5)
  String familyId;

  @override
  String toString() {
    return 'MediaUploadDTO(mediaUrlData: $mediaUrlData, file: $file, type: $type, imageCount: $imageCount, memberId: $memberId, familyId: $familyId)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MediaUploadDTOCopyWith<_$_MediaUploadDTO> get copyWith =>
      __$$_MediaUploadDTOCopyWithImpl<_$_MediaUploadDTO>(this, _$identity);
}

abstract class _MediaUploadDTO implements MediaUploadDTO {
  factory _MediaUploadDTO(
      {@HiveField(0) required Map<String, dynamic> mediaUrlData,
      @HiveField(1) required MultipartFile file,
      @HiveField(2) required String type,
      @HiveField(3) required int imageCount,
      @HiveField(4) required String memberId,
      @HiveField(5) required String familyId}) = _$_MediaUploadDTO;

  @override
  @HiveField(0)
  Map<String, dynamic> get mediaUrlData;
  @HiveField(0)
  set mediaUrlData(Map<String, dynamic> value);
  @override
  @HiveField(1)
  MultipartFile get file;
  @HiveField(1)
  set file(MultipartFile value);
  @override
  @HiveField(2)
  String get type;
  @HiveField(2)
  set type(String value);
  @override
  @HiveField(3)
  int get imageCount;
  @HiveField(3)
  set imageCount(int value);
  @override
  @HiveField(4)
  String get memberId;
  @HiveField(4)
  set memberId(String value);
  @override
  @HiveField(5)
  String get familyId;
  @HiveField(5)
  set familyId(String value);
  @override
  @JsonKey(ignore: true)
  _$$_MediaUploadDTOCopyWith<_$_MediaUploadDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
