import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:modak_flutter_app/provider/album_provider.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/utils/file_system_util.dart';
import 'package:modak_flutter_app/utils/prefs_util.dart';

Future<Map<String, dynamic>> getMediaNames() async {
  try {
    Response response = await Dio(BaseOptions(queryParameters: {
      'f': PrefsUtil.getInt("family_id"),
      'c': 100,
    })).get(
      "${dotenv.get("CHAT_HTTP")}/dev/media/${AlbumProvider.messengerLastId}",
    );

    return {
      "result": "SUCCESS",
      "response": response,
    };
  } catch (e) {
    if (e is DioError) {
      print(e.response);
    }
    return {"result": "FAIL", "message": "GETMEDIA"};
  }
}

Future<Map<String, dynamic>> getMedia(List<dynamic> items) async {
  Directory? messengerDirectory = await FileSystemUtil.getMediaDirectory();

  if (messengerDirectory == null) {
    return {"result": "FAIL", "message": "NOSUCHDIRECTORY"};
  }

  List<String> requestList = [];
  for (Map<String, dynamic> item in items) {
    if (!File("${messengerDirectory.path}/${item['key']}").existsSync()) {
      requestList.add(item['key']);
    }
  }

  if (requestList.isNotEmpty) {
    Response response =
        await Dio().post("${dotenv.get("CHAT_HTTP")}/dev/media/url", data: {
      'list': requestList,
    });

    List<dynamic> urlList = jsonDecode(response.data)['url_list'];

    for (String url in urlList) {
      RegExp regExp = RegExp(r'.com\/(\w|\W)+\?');
      String temp = (regExp.stringMatch(url).toString());
      String fileName = temp.substring(5, temp.length - 1);

      final ByteData imageData =
          await NetworkAssetBundle(Uri.parse(url)).load("");
      final Uint8List bytes = imageData.buffer.asUint8List();

      File file = await File('${messengerDirectory.path}/$fileName')
          .create(recursive: true);
      file.writeAsBytesSync(bytes);
    }
  }

  List<File> files = [];
  for (Map<String, dynamic> item in items) {
    files.add(File("${messengerDirectory.path}/${item['key']}"));
  }

  return {
    "result": "SUCCESS",
    "response": files,
  };
}

Future<Map<String, dynamic>> mediaLoading() async {
  Map<String, dynamic> getMediaNamesResponse = await getMediaNames();
  if (getMediaNamesResponse['result'] == "FAIL") {
    return getMediaNamesResponse;
  }

  List<dynamic> images =
      jsonDecode(getMediaNamesResponse['response'].data)['album'];
  Map<String, dynamic> getMediaResponse = await getMedia(images);

  return getMediaResponse;
}
