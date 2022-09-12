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
      memberId: fields[0] as int,
      name: fields[1] as String,
      birthDay: fields[2] as String,
      isLunar: fields[3] as bool,
      role: fields[4] as String,
      fcmToken: fields[5] as String,
      color: fields[6] as String,
      timeTags: (fields[7] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, _$_User obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.memberId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.birthDay)
      ..writeByte(3)
      ..write(obj.isLunar)
      ..writeByte(4)
      ..write(obj.role)
      ..writeByte(5)
      ..write(obj.fcmToken)
      ..writeByte(6)
      ..write(obj.color)
      ..writeByte(7)
      ..write(obj.timeTags);
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
      memberId: json['memberId'] as int,
      name: json['name'] as String,
      birthDay: json['birthDay'] as String,
      isLunar: json['isLunar'] as bool,
      role: json['role'] as String,
      fcmToken: json['fcmToken'] as String,
      color: json['color'] as String,
      timeTags:
          (json['timeTags'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'memberId': instance.memberId,
      'name': instance.name,
      'birthDay': instance.birthDay,
      'isLunar': instance.isLunar,
      'role': instance.role,
      'fcmToken': instance.fcmToken,
      'color': instance.color,
      'timeTags': instance.timeTags,
    };
