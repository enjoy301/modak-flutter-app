// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Chat _$$_ChatFromJson(Map<String, dynamic> json) => _$_Chat(
      userId: json['userId'] as int,
      content: json['content'] as String,
      sendAt: (json['sendAt'] as num).toDouble(),
      metaData: json['metaData'] as Map<String, dynamic>?,
      unReadCount: json['unReadCount'] as int,
    );

Map<String, dynamic> _$$_ChatToJson(_$_Chat instance) => <String, dynamic>{
      'userId': instance.userId,
      'content': instance.content,
      'sendAt': instance.sendAt,
      'metaData': instance.metaData,
      'unReadCount': instance.unReadCount,
    };
