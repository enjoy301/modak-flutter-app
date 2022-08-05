// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatModel _$$_ChatModelFromJson(Map<String, dynamic> json) => _$_ChatModel(
      userId: json['userId'] as int,
      content: json['content'] as String,
      sendAt: (json['sendAt'] as num).toDouble(),
      metaData: json['metaData'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$_ChatModelToJson(_$_ChatModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'content': instance.content,
      'sendAt': instance.sendAt,
      'metaData': instance.metaData,
    };
