// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<_$_User> {
  @override
  final int typeId = 0;

  @override
  _$_User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_User(
      name: fields[0] as String,
      birthDay: fields[1] as String,
      isLunar: fields[2] as bool,
      role: fields[3] as String,
      fcmToken: fields[4] as String,
      color: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _$_User obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.birthDay)
      ..writeByte(2)
      ..write(obj.isLunar)
      ..writeByte(3)
      ..write(obj.role)
      ..writeByte(4)
      ..write(obj.fcmToken)
      ..writeByte(5)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      name: json['name'] as String,
      birthDay: json['birthDay'] as String,
      isLunar: json['isLunar'] as bool,
      role: json['role'] as String,
      fcmToken: json['fcmToken'] as String,
      color: json['color'] as String,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'name': instance.name,
      'birthDay': instance.birthDay,
      'isLunar': instance.isLunar,
      'role': instance.role,
      'fcmToken': instance.fcmToken,
      'color': instance.color,
    };
