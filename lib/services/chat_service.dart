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
    'c': UserProvider.user_id,
  })).get(
    '${dotenv.get("CHAT_HTTP")}/dev/messages/0',
  );

  List<dynamic> tempList = (jsonDecode(response.data as String)['message']);
  for (var item in tempList) {
    // ignore: use_build_context_synchronously
    context.read<ChatProvider>().addChat(ChatModel(
        userId: item['user_id'],
        content: item['content'],
        sendAt: item['send_at'],
        typeCode: item['type_code'],
        metaData: item['metadata']));
  }
}

Future<Map<String, dynamic>> sendMedia(MultipartFile? file, String type, int imageCount) async {
  if (file == null) {
    return {"result": "FAIL", "message": "FILE_NULL"};
  }
  Map<String, dynamic> getMediaUrlResponse = await getMediaUrl();
  if (getMediaUrlResponse['result'] == "FAIL") {
    return {"result": "FAIL", "message": "URL"};
  }
  Map<String, dynamic> mediaUrlData =
      jsonDecode(getMediaUrlResponse['response'].data);

  Map<String, dynamic> uploadMediaResponse =
      await uploadMedia(mediaUrlData, file, type, imageCount);
  if (uploadMediaResponse['result'] == "FAIL") {
    return {"result": "FAIL", "message": "UPLOAD"};
  }
  return {"result": "SUCCESS", "response": uploadMediaResponse};
}

Future<Map<String, dynamic>> getMediaUrl() async {
  try {
    var res = await Dio(BaseOptions(
      contentType: 'multipart/form-data',
    )).get(
        "${dotenv.get("CHAT_HTTP")}/dev/media/url?u=${UserProvider.user_id}&f=${UserProvider.family_id}");
    return {"response": res, "result": "SUCCESS"};
  } catch (e) {
    return {"result": "FAIL"};
  }
}

Future<Map<String, dynamic>> uploadMedia(
    Map<String, dynamic> mediaUrlData, MultipartFile file, String type, int imageCount) async {
  try {
    String xAmzAlgorithm = mediaUrlData['fields']['x-amz-algorithm'];
    String xAmzCredential = mediaUrlData['fields']['x-amz-credential'];
    String xAmzDate = mediaUrlData['fields']['x-amz-date'];
    String xAmzSecurityToken = mediaUrlData['fields']['x-amz-security-token'];
    String policy = mediaUrlData['fields']['policy'];
    String xAmzSignature = mediaUrlData['fields']['x-amz-signature'];
    int xAmzMetaImageCount = imageCount;

    debugPrint("""
    ----------------------------------------------------
    Media information to S3
    algo: $xAmzAlgorithm
    cred: $xAmzCredential
    date: $xAmzDate
    token: $xAmzSecurityToken
    policy: $policy
    sign: $xAmzSignature
    userId: ${UserProvider.user_id}
    familyId: ${UserProvider.family_id}
    imageCount: $xAmzMetaImageCount
    ----------------------------------------------------
    """);

    var formData = FormData.fromMap({
      "key": "${UserProvider.family_id}/${UserProvider.user_id}/${DateTime.now().millisecondsSinceEpoch}.$type",
      "x-amz-algorithm": xAmzAlgorithm.trim(),
      "x-amz-credential": xAmzCredential.trim(),
      "x-amz-date": xAmzDate.trim(),
      "x-amz-security-token": xAmzSecurityToken.trim(),
      "policy": policy.trim(),
      "x-amz-signature": xAmzSignature.trim(),
      "x-amz-meta-user_id": UserProvider.user_id,
      "x-amz-meta-family_id": UserProvider.family_id,
      "x-amz-meta-image_count": xAmzMetaImageCount,
      "file": file,
    });


    var response = await Dio(BaseOptions(headers: {
      "Content-Type": "multipart/form-data",
      'Connection': 'keep-alive',
      "Accept": "*/*"
    })).post("https://chatapp-private.s3.amazonaws.com/", data: formData);
    print(response);

    return {"result": "SUCCESS"};
  } catch (e) {
    print(e);
    return {"result": "FAIL"};
  }
}
