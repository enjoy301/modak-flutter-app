import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:modak_flutter_app/data/model/chat_model.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/utils/prefs_util.dart';
import 'package:provider/provider.dart';

Future<bool> sendChat(ChatModel chat) async {
  final response =
      await Dio().post('${dotenv.get("CHAT_HTTP")}/dev/messages', data: {
    'family_id': PrefsUtil.getInt("family_id"),
    'user_id': PrefsUtil.getInt("user_id"),
    'content': chat.content,
    'metadata': chat.metaData,
  });

  print(response.statusCode);
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}

void getChats(BuildContext context) async {
  final chatResponse = await Dio(BaseOptions(queryParameters: {
    'f': PrefsUtil.getInt("family_id"),
    'c': 100,
  })).get(
    '${dotenv.get("CHAT_HTTP")}/dev/messages/0',
  );

  final connectionResponse = await Dio(BaseOptions(queryParameters: {
    'f': PrefsUtil.getInt("family_id"),
  })).get(
    '${dotenv.get("CHAT_HTTP")}/dev/connections',
  );

  List<dynamic> chatList = (jsonDecode(chatResponse.data as String)['message']);
  // Future(() => context.read<ChatProvider>().setChat(chatList));

  List<dynamic> connectionList =
      (jsonDecode(connectionResponse.data as String)['connection_data']);
  // Future(() => context.read<ChatProvider>().setConnection(connectionList));
}

Future<Map<String, dynamic>> sendMedia(
    MultipartFile? file, String type, int imageCount) async {
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
        "${dotenv.get("CHAT_HTTP")}/dev/media/url?u=${PrefsUtil.getInt("user_id")}&f=${PrefsUtil.getInt("family_id")}");
    return {"response": res, "result": "SUCCESS"};
  } catch (e) {
    return {"result": "FAIL"};
  }
}

Future<Map<String, dynamic>> uploadMedia(Map<String, dynamic> mediaUrlData,
    MultipartFile file, String type, int imageCount) async {
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
    userId: ${PrefsUtil.getInt("user_id")}
    familyId: ${PrefsUtil.getInt("family_id")}
    imageCount: $xAmzMetaImageCount
    ----------------------------------------------------
    """);

    var formData = FormData.fromMap({
      "key":
          "${PrefsUtil.getInt("family_id")}/${DateTime.now().millisecondsSinceEpoch}/Modak.zip",
      "x-amz-algorithm": xAmzAlgorithm.trim(),
      "x-amz-credential": xAmzCredential.trim(),
      "x-amz-date": xAmzDate.trim(),
      "x-amz-security-token": xAmzSecurityToken.trim(),
      "policy": policy.trim(),
      "x-amz-signature": xAmzSignature.trim(),
      "x-amz-meta-user_id": PrefsUtil.getInt("user_id"),
      "x-amz-meta-family_id": PrefsUtil.getInt("family_id"),
      "x-amz-meta-image_count": xAmzMetaImageCount,
      "file": file,
    });

    var response = await Dio(BaseOptions(headers: {
      "Content-Type": "multipart/form-data",
      'Connection': 'keep-alive',
      "Accept": "*/*"
    })).post(dotenv.get("S3_ENDPOINT"), data: formData);
    print(response);

    return {"result": "SUCCESS"};
  } catch (e) {
    print(e);
    return {"result": "FAIL"};
  }
}
