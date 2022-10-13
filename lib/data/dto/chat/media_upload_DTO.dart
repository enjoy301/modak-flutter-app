import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'media_upload_DTO.freezed.dart';
part 'media_upload_DTO.g.dart';

@unfreezed
class MediaUploadDTO with _$MediaUploadDTO {
  @HiveType(typeId: 31)
  factory MediaUploadDTO({
    @HiveField(0) required Map<String, dynamic> mediaUrlData,
    @HiveField(1) required MultipartFile file,
    @HiveField(2) required String type,
    @HiveField(3) required int imageCount,
    @HiveField(4) required String memberId,
    @HiveField(5) required String familyId,
  }) = _MediaUploadDTO;
}
