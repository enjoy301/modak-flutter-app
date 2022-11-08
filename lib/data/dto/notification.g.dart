// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotiAdapter extends TypeAdapter<_$_Noti> {
  @override
  final int typeId = 32;

  @override
  _$_Noti read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_Noti(
      notiType: fields[0] as String,
      title: fields[1] as String,
      des: fields[2] as String,
      isRead: fields[3] as bool,
      metaData: (fields[4] as Map).cast<dynamic, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, _$_Noti obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.notiType)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.des)
      ..writeByte(3)
      ..write(obj.isRead)
      ..writeByte(4)
      ..write(obj.metaData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotiAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Noti _$$_NotiFromJson(Map<String, dynamic> json) => _$_Noti(
      notiType: json['notiType'] as String,
      title: json['title'] as String,
      des: json['des'] as String,
      isRead: json['isRead'] as bool,
      metaData: json['metaData'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$_NotiToJson(_$_Noti instance) => <String, dynamic>{
      'notiType': instance.notiType,
      'title': instance.title,
      'des': instance.des,
      'isRead': instance.isRead,
      'metaData': instance.metaData,
    };
