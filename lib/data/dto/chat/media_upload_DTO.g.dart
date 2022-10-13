// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_upload_DTO.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MediaUploadDTOAdapter extends TypeAdapter<_$_MediaUploadDTO> {
  @override
  final int typeId = 31;

  @override
  _$_MediaUploadDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_MediaUploadDTO(
      mediaUrlData: (fields[0] as Map).cast<String, dynamic>(),
      file: fields[1] as MultipartFile,
      type: fields[2] as String,
      imageCount: fields[3] as int,
      memberId: fields[4] as String,
      familyId: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _$_MediaUploadDTO obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.mediaUrlData)
      ..writeByte(1)
      ..write(obj.file)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.imageCount)
      ..writeByte(4)
      ..write(obj.memberId)
      ..writeByte(5)
      ..write(obj.familyId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MediaUploadDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
