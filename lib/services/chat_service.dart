import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:modak_flutter_app/data/model/chat.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/utils/prefs_util.dart';
import 'package:provider/provider.dart';

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
