// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_paging_DTO.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatPagingDTOAdapter extends TypeAdapter<_$_ChatPagingDTO> {
  @override
  final int typeId = 30;

  @override
  _$_ChatPagingDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_ChatPagingDTO(
      count: fields[0] as int,
      lastId: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, _$_ChatPagingDTO obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.count)
      ..writeByte(1)
      ..write(obj.lastId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatPagingDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
