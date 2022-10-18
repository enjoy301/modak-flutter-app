import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modak_flutter_app/data/repository/album_repository.dart';

import '../constant/strings.dart';
import '../utils/file_system_util.dart';

class AlbumProvider extends ChangeNotifier {
  init() {
    clear();
    notifyListeners();
  }

  final AlbumRepository _albumRepository = AlbumRepository();

  static int messengerLastId = 0;

  List<dynamic> _messengerMedias = [];
  List<File> _messengerAlbumFiles = [];
  File? _messengerThumbnail;


  get messengerMedias => _messengerMedias;
  get messengerAlbumFiles => _messengerAlbumFiles;
  get messengerThumbnail => _messengerThumbnail;

  void mediaLoading() async {
    Map<String, dynamic> getMediaNamesResponse =
        await _albumRepository.getMediaNames(0);

    if (getMediaNamesResponse['result'] == Strings.fail) {
      return;
    }

    List<dynamic> images =
        jsonDecode(getMediaNamesResponse['response']['data'])['album'];
    Map<String, dynamic> getMediaResponse = await getMedia(images);

    if (getMediaResponse['result'] == Strings.fail) {
      return;
    }

    _messengerMedias = images;
    setFileToMessengerAlbum(getMediaResponse['response']);
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

      List<dynamic> urlList =
          jsonDecode(response['response']['data'])['url_list'];

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

  clear() {
    _messengerMedias = [];
    _messengerAlbumFiles = [];
    _messengerThumbnail = null;
  }
}
