// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_content.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodayContentAdapter extends TypeAdapter<_$_TodayContent> {
  @override
  final int typeId = 50;

  @override
  _$_TodayContent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_TodayContent(
      id: fields[0] as int,
      type: fields[1] as String,
      title: fields[2] as String,
      desc: fields[3] as String,
      url: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _$_TodayContent obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.desc)
      ..writeByte(4)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodayContentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TodayContent _$$_TodayContentFromJson(Map<String, dynamic> json) =>
    _$_TodayContent(
      id: json['id'] as int,
      type: json['type'] as String,
      title: json['title'] as String,
      desc: json['desc'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$$_TodayContentToJson(_$_TodayContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'desc': instance.desc,
      'url': instance.url,
    };
