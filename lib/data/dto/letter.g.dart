// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'letter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LetterAdapter extends TypeAdapter<_$_Letter> {
  @override
  final int typeId = 22;

  @override
  _$_Letter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_Letter(
      fromMemberId: fields[0] as int,
      toMemberId: fields[1] as int,
      content: fields[2] as String,
      envelope: fields[3] as EnvelopeType,
      date: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _$_Letter obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.fromMemberId)
      ..writeByte(1)
      ..write(obj.toMemberId)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.envelope)
      ..writeByte(4)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LetterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Letter _$$_LetterFromJson(Map<String, dynamic> json) => _$_Letter(
      fromMemberId: json['fromMemberId'] as int,
      toMemberId: json['toMemberId'] as int,
      content: json['content'] as String,
      envelope: $enumDecode(_$EnvelopeTypeEnumMap, json['envelope']),
      date: json['date'] as String,
    );

Map<String, dynamic> _$$_LetterToJson(_$_Letter instance) => <String, dynamic>{
      'fromMemberId': instance.fromMemberId,
      'toMemberId': instance.toMemberId,
      'content': instance.content,
      'envelope': _$EnvelopeTypeEnumMap[instance.envelope]!,
      'date': instance.date,
    };

const _$EnvelopeTypeEnumMap = {
  EnvelopeType.red: 'red',
  EnvelopeType.brown: 'brown',
  EnvelopeType.cyan: 'cyan',
  EnvelopeType.green: 'green',
};
