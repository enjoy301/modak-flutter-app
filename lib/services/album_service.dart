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

Future<Map<String, dynamic>> getMediaNames() async {
  try {
    Response response = await Dio().get(
        "${dotenv.get("CHAT_HTTP")}/dev/media/${AlbumProvider.messengerLastId.toString()}?f=${UserProvider.family_id}&c=10");
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

  print(messengerDirectory.path);
  List<String> list = [];
  for (Map<String, dynamic> item in items) {
    if (!File("${messengerDirectory.path}/${item['key']}").existsSync()) {
      list.add(item['key']);
    }
  }

  Response response =
      await Dio().post("${dotenv.get("CHAT_HTTP")}/dev/media/url", data: {
    'list': list,
  });

  List<dynamic> urlList = jsonDecode(response.data)['url_list'];
  print("urlList: $urlList");

  List<File> files = [];

  for (String url in urlList) {
    RegExp regExp = RegExp(r'.com\/(\w|\W)+\?');
    String temp = (regExp.stringMatch(url).toString());
    String fileName = temp.substring(5, temp.length - 1);

    final ByteData imageData = await NetworkAssetBundle(Uri.parse(url)).load("");
    final Uint8List bytes = imageData.buffer.asUint8List();

    File file = await File('${messengerDirectory.path}/$fileName').create(recursive: true);
    file.writeAsBytesSync(bytes);

    print("이거 아니면 씨발 ${await File('${messengerDirectory.path}/$fileName').existsSync()}");

    files.add(File("${messengerDirectory.path}/$fileName"));

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
