import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modak_flutter_app/data/repository/album_repository.dart';

import '../constant/strings.dart';
import '../utils/file_system_util.dart';

class AlbumProvider extends ChangeNotifier {
  init() {
    clear();
    notifyListeners();
  }

  final AlbumRepository _albumRepository = AlbumRepository();

  late int mediaLastId;
  late String lastDate;
  late int index;

  /// 모든 미디어 파일들을 build할 때 쓰려고
  late List<List<File>> _albumBuildFileList = [];
  get albumBuildFileList => _albumBuildFileList;

  late ScrollController _scrollController;
  ScrollController get scrollController => _scrollController;

  late bool isInfinityScrollLoading;

  /// 앨범 UI build시 실행되는 initial 함수
  Future initialMediaLoading() async {
    _albumBuildFileList = [];
    _scrollController = ScrollController();
    isInfinityScrollLoading = false;
    mediaLastId = 0;
    index = -1;
    lastDate = "2001-03-01";

    Map<String, dynamic> mediaInfoResponse =
        await _albumRepository.getMediaInfoList(mediaLastId, 20);
    if (mediaInfoResponse['result'] == Strings.fail) {
      return;
    }

    List<dynamic> mediaInfoList =
        jsonDecode(mediaInfoResponse['response']['data'])['album'];
    mediaLastId = jsonDecode(
      mediaInfoResponse['response']['data'],
    )['last_id'];
    if (mediaInfoList.isEmpty) {
      return;
    }

    Map<String, dynamic> mediaFileListResponse = await loadMedia(mediaInfoList);
    if (mediaFileListResponse['result'] == Strings.fail) {
      return;
    }

    setAlbumBuildFileList(mediaFileListResponse['response']);

    Fluttertoast.showToast(msg: "앨범 성공적으로 불러옴");
  }

  /// 미디어 info를 넘기면, 디렉토리에서 찾던 다운하던 로드하고 로드된 파일을 리턴함.
  Future<Map<String, dynamic>> loadMedia(
    List<dynamic> mediaInfoList,
  ) async {
    String mediaDirectoryPath = await FileSystemUtil.getMediaDirectory();

    if (mediaDirectoryPath == "") {
      return {"result": "FAIL", "message": "NOSUCHDIRECTORY"};
    }

    /// Directory 검색 후, 서버에 요청해야 할 파일 찾기
    List<String> downloadKeyList = [];
    for (Map<String, dynamic> mediaInfo in mediaInfoList) {
      if (!File("$mediaDirectoryPath/${mediaInfo['key']}").existsSync()) {
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
          '$mediaDirectoryPath/$fileName',
        ).create(recursive: true);
        file.writeAsBytesSync(bytes);
      }
    }

    List<File> files = [];
    for (Map<String, dynamic> mediaInfo in mediaInfoList) {
      files.add(
        File("$mediaDirectoryPath/${mediaInfo['key']}"),
      );
    }

    return {
      "result": "SUCCESS",
      "response": files,
    };
  }

  void addScrollListener() {
    scrollController.addListener(
      () async {
        if (scrollController.offset ==
                scrollController.position.maxScrollExtent &&
            !scrollController.position.outOfRange) {
          if (isInfinityScrollLoading == true) {
            return;
          }

          isInfinityScrollLoading = true;

          Map<String, dynamic> mediaInfoResponse =
              await _albumRepository.getMediaInfoList(
            mediaLastId,
            20,
          );

          if (mediaInfoResponse['result'] == Strings.fail) {
            return;
          }

          List<dynamic> mediaInfoList = jsonDecode(
            mediaInfoResponse['response']['data'],
          )['album'];
          mediaLastId = jsonDecode(
            mediaInfoResponse['response']['data'],
          )['last_id'];

          if (mediaInfoList.isEmpty) {
            isInfinityScrollLoading = false;
            return;
          }

          Map<String, dynamic> mediaFileListResponse =
              await loadMedia(mediaInfoList);
          if (mediaFileListResponse['result'] == Strings.fail) {
            return;
          }

          setAlbumBuildFileList(mediaFileListResponse['response']);

          notifyListeners();
          isInfinityScrollLoading = false;
        }
      },
    );
  }

  void setAlbumBuildFileList(List<File> fileList) {
    String nowDate = "";
    for (File mediaFile in fileList) {
      nowDate = mediaFile.absolute.path.split('/').last.split('T')[0];
      if (lastDate != nowDate) {
        index++;
        _albumBuildFileList.add([mediaFile]);

        lastDate = nowDate;
      } else {
        _albumBuildFileList[index].add(mediaFile);
      }
    }

    notifyListeners();
  }

  clear() {
    _albumBuildFileList = [];
  }
}
