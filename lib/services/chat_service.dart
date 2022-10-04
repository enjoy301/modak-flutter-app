import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:modak_flutter_app/data/model/chat.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/utils/prefs_util.dart';
import 'package:provider/provider.dart';

import '../constant/strings.dart';
import '../data/datasource/remote_datasource.dart';

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
    var res = await Dio().get(
      "${dotenv.get("CHAT_HTTP")}/media/post-url",
    );
    return {"response": res, "result": "SUCCESS"};
  } catch (e) {
    return {"result": "FAIL"};
  }
}

Future<Map<String, dynamic>> uploadMedia(Map<String, dynamic> mediaUrlData,
    MultipartFile file, String type, int imageCount) async {
  var memberId = await RemoteDataSource.storage.read(key: Strings.memberId);
  var familyId = await RemoteDataSource.storage.read(key: Strings.familyId);

  try {
    String xAmzAlgorithm = mediaUrlData['fields']['x-amz-algorithm'];
    String xAmzCredential = mediaUrlData['fields']['x-amz-credential'];
    String xAmzDate = mediaUrlData['fields']['x-amz-date'];
    String xAmzSecurityToken = mediaUrlData['fields']['x-amz-security-token'];
    String policy = mediaUrlData['fields']['policy'];
    String xAmzSignature = mediaUrlData['fields']['x-amz-signature'];
    int xAmzMetaImageCount = imageCount;

    var formData = FormData.fromMap({
      "key": "$familyId/${DateTime.now().millisecondsSinceEpoch}/Modak.zip",
      "x-amz-algorithm": xAmzAlgorithm.trim(),
      "x-amz-credential": xAmzCredential.trim(),
      "x-amz-date": xAmzDate.trim(),
      "x-amz-security-token": xAmzSecurityToken.trim(),
      "policy": policy.trim(),
      "x-amz-signature": xAmzSignature.trim(),
      "x-amz-meta-user_id": memberId,
      "x-amz-meta-family_id": familyId,
      "x-amz-meta-image_count": xAmzMetaImageCount,
      "file": file,
    });

    var response = await Dio(BaseOptions(headers: {
      "Content-Type": "multipart/form-data",
      'Connection': 'keep-alive',
      "Accept": "*/*"
    })).post(dotenv.get("S3_ENDPOINT"), data: formData);

    return {"result": "SUCCESS"};
  } catch (e) {
    return {"result": "FAIL"};
  }
}
