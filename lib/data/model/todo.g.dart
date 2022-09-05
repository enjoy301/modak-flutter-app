// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoAdapter extends TypeAdapter<_$_Todo> {
  @override
  final int typeId = 1;

  @override
  _$_Todo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_Todo(
      todoId: fields[0] as int,
      groupTodoId: fields[1] as int,
      memberId: fields[2] as int,
      title: fields[3] as String,
      color: fields[4] as String,
      isDone: fields[5] as bool,
      timeTag: fields[6] as String?,
      repeatTag: fields[7] as String?,
      memo: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$_Todo obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.todoId)
      ..writeByte(1)
      ..write(obj.groupTodoId)
      ..writeByte(2)
      ..write(obj.memberId)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.color)
      ..writeByte(5)
      ..write(obj.isDone)
      ..writeByte(6)
      ..write(obj.timeTag)
      ..writeByte(7)
      ..write(obj.repeatTag)
      ..writeByte(8)
      ..write(obj.memo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Todo _$$_TodoFromJson(Map<String, dynamic> json) => _$_Todo(
      todoId: json['todoId'] as int,
      groupTodoId: json['groupTodoId'] as int,
      memberId: json['memberId'] as int,
      title: json['title'] as String,
      color: json['color'] as String,
      isDone: json['isDone'] as bool,
      timeTag: json['timeTag'] as String?,
      repeatTag: json['repeatTag'] as String?,
      memo: json['memo'] as String?,
    );

Map<String, dynamic> _$$_TodoToJson(_$_Todo instance) => <String, dynamic>{
      'todoId': instance.todoId,
      'groupTodoId': instance.groupTodoId,
      'memberId': instance.memberId,
      'title': instance.title,
      'color': instance.color,
      'isDone': instance.isDone,
      'timeTag': instance.timeTag,
      'repeatTag': instance.repeatTag,
      'memo': instance.memo,
    };
