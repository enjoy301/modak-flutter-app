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

  /// 모든 미디어 파일들을 build할 때 쓰려고
  late List<List<File>> _albumBuildFileList = [];
  get albumBuildFileList => _albumBuildFileList;

  /// 앨범 UI build시 실행되는 initial 함수
  Future initialMediaLoading() async {
    Map<String, dynamic> mediaInfoResponse =
        await _albumRepository.getMediaInfoList(messengerLastId, 20);
    if (mediaInfoResponse['result'] == Strings.fail) {
      return;
    }

    List<dynamic> mediaInfoList =
        jsonDecode(mediaInfoResponse['response']['data'])['album'];
    log("$mediaInfoList");

    Map<String, dynamic> mediaFileListResponse = await loadMedia(mediaInfoList);
    if (mediaFileListResponse['result'] == Strings.fail) {
      return;
    }

    setAlbumBuildFileList(mediaFileListResponse['response']);
  }

  /// 미디어 info를 넘기면, 디렉토리에서 찾던 다운하던 로드하고 로드된 파일을 리턴함.
  Future<Map<String, dynamic>> loadMedia(
    List<dynamic> mediaInfoList,
  ) async {
    Directory? mediaDirectory = await FileSystemUtil.getMediaDirectory();

    if (mediaDirectory == null) {
      return {"result": "FAIL", "message": "NOSUCHDIRECTORY"};
    }

    /// Directory 검색 후, 서버에 요청해야 할 파일 찾기
    List<String> downloadKeyList = [];
    for (Map<String, dynamic> mediaInfo in mediaInfoList) {
      if (!File("${mediaDirectory.path}/${mediaInfo['key']}").existsSync()) {
        downloadKeyList.add(mediaInfo['key']);
      }
    }

    /// 없는 미디어 다운로드
    if (downloadKeyList.isNotEmpty) {
      Map<String, dynamic> urlResponse = await _albumRepository.getMediaURL(
        downloadKeyList,
      );

      List<dynamic> urlList = jsonDecode(
        urlResponse['response']['data'],
      )['url_list'];

      for (String url in urlList) {
        log("url $url");
        RegExp regExp = RegExp(r'.com\/(\w|\W)+\?');
        String temp = (regExp.stringMatch(url).toString());
        String fileName = temp.substring(5, temp.length - 1);

        final ByteData imageData = await NetworkAssetBundle(
          Uri.parse(url),
        ).load("");
        final Uint8List bytes = imageData.buffer.asUint8List();

        File file = await File(
          '${mediaDirectory.path}/$fileName',
        ).create(recursive: true);
        file.writeAsBytesSync(bytes);
      }
    }

    List<File> files = [];
    for (Map<String, dynamic> mediaInfo in mediaInfoList) {
      files.add(
        File("${mediaDirectory.path}/${mediaInfo['key']}"),
      );
    }

    return {
      "result": "SUCCESS",
      "response": files,
    };
  }

  void setAlbumBuildFileList(List<File> fileList) {
    _albumBuildFileList = [fileList];
    for (File mediaFile in fileList) {
      log("-> ${mediaFile.absolute.path.split('/').last.split('s')[0]}");
    }

    notifyListeners();
  }

  clear() {
    _albumBuildFileList = [];
  }
}
