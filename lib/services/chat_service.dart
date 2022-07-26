import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:modak_flutter_app/models/chat_model.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:provider/provider.dart';

Future<bool> sendChat(
    BuildContext context, String content, String typeCode) async {
  final response =
      await Dio().post('${dotenv.get("CHAT_HTTP")}/dev/messages', data: {
    'family_id': UserProvider.family_id,
    'user_id': UserProvider.user_id,
    'content': content,
    'type_code': typeCode,
  });

  print(response.statusCode);
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}

void getChats(BuildContext context) async {
  final response = await Dio(BaseOptions(queryParameters: {
    'f': UserProvider.family_id,
    'c': 100,
  })).get(
    '${dotenv.get("CHAT_HTTP")}/dev/messages/0',
  );

  List<dynamic> tempList =  (jsonDecode(response.data as String)['message']);
  for (var item in tempList) {
    // ignore: use_build_context_synchronously
    context.read<ChatProvider>().add(ChatModel(userId: item['user_id'], content: item['content'], sendAt: item['send_at'], typeCode: item['type_code'], metaData: item['metadata']));
  }
}


void sendMedia(FormData formData) async {
  var res = await Dio(BaseOptions(
    contentType: 'multipart/form-data',
  )).post("${dotenv.get("CHAT_HTTP")}/dev/media?u=${UserProvider.user_id}&f=${UserProvider.family_id}", data: formData);

  print(res);
}


