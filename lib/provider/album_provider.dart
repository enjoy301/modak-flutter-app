import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modak_flutter_app/data/repository/album_repository.dart';

import '../utils/file_system_util.dart';

class AlbumProvider extends ChangeNotifier {
  init() {
    _albumRepository = AlbumRepository();
  }

  static late final AlbumRepository _albumRepository;

  static int messengerLastId = 0;

  List<File> _messengerAlbumFiles = [];
  get messengerAlbumFiles => _messengerAlbumFiles;
  File? _messengerThumbnail;
  get messengerThumbnail => _messengerThumbnail;

  Future<Map<String, dynamic>> mediaLoading() async {
    Map<String, dynamic> getMediaNamesResponse =
        await _albumRepository.getMediaNames(0);
    if (getMediaNamesResponse['result'] == "FAIL") {
      return getMediaNamesResponse;
    }

    List<dynamic> images =
        jsonDecode(getMediaNamesResponse['response'].data)['album'];
    Map<String, dynamic> getMediaResponse = await getMedia(images);

    return getMediaResponse;
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
      Map<String, dynamic> response =
          await _albumRepository.getMediaURL(requestList);

      List<dynamic> urlList = jsonDecode(response.toString())['url_list'];

      for (String url in urlList) {
        log("url -> $url");
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

  void setFileToMessengerAlbum(List<File> fileList) {
    _messengerAlbumFiles = [];

    if (fileList.isNotEmpty) {
      _messengerThumbnail = fileList[0];

      for (File file in fileList) {
        _messengerAlbumFiles.add(file);
      }

      notifyListeners();
    }
  }

  File getFileFromMessengerAlbumAt(int index) {
    return _messengerAlbumFiles[index];
  }

  final List<File> _todoAlbumFiles = [];
  get todoAlbumFiles => _todoAlbumFiles;
  File? _todoThumbnail;
  get todoThumbnail => _todoThumbnail;

  void addFileToTodoAlbum(File file) {
    _todoAlbumFiles.add(file);
    notifyListeners();
  }

  File getFileFromTodoAlbumAt(int index) {
    return _todoAlbumFiles[index];
  }
}
