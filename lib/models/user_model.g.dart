// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      name: json['name'] as String?,
      birthDay: json['birthDay'] as String?,
      isLunar: json['isLunar'] as bool?,
      role: $enumDecodeNullable(_$FamilyTypeEnumMap, json['role']),
      fcmToken: json['fcmToken'] as String?,
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'birthDay': instance.birthDay,
      'isLunar': instance.isLunar,
      'role': _$FamilyTypeEnumMap[instance.role],
      'fcmToken': instance.fcmToken,
    };

const _$FamilyTypeEnumMap = {
  FamilyType.dad: 'dad',
  FamilyType.mom: 'mom',
  FamilyType.dau: 'dau',
  FamilyType.son: 'son',
};
