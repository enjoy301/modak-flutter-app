import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modak_flutter_app/data/repository/album_repository.dart';
import 'package:path/path.dart';

import '../constant/strings.dart';
import '../utils/file_system_util.dart';
import '../utils/media_util.dart';

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

  late List<dynamic> _faceDataList = [];
  get faceDataList => _faceDataList;

  late List<File> _faceFileList = [];
  get faceFileList => _faceFileList;

  late List<dynamic> _labelDataList = [];
  get labelDataList => _labelDataList;

  late List<File> _labelFileList = [];
  get labelFileList => _labelFileList;

  late Map<String, File> _thumbnailList;
  get thumbnailList => _thumbnailList;

  ScrollController? _scrollController;
  ScrollController? get scrollController => _scrollController;

  ScrollController? _themeScrollController;
  ScrollController? get themeScrollController => _themeScrollController;

  late bool isInfinityScrollLoading;

  late int faceLastId;

  late List<File> _faceDetailFileList = [];
  get faceDetailFileList => _faceDetailFileList;

  ScrollController? _faceScrollController;
  ScrollController? get faceScrollController => _faceScrollController;

  late int labelLastId;
  late int _selectedLabel;
  get selectedLabel => _selectedLabel;

  late List<File> _labelDetailFileList;
  get labelDetailFileList => _labelDetailFileList;

  late bool _isLabelLoading;
  get isLabelLoading => _isLabelLoading;

  Future<void> initTotalData() async {
    _albumBuildFileList = [];
    _labelDetailFileList = [];
    _faceDataList = [];
    _faceFileList = [];
    _labelDataList = [];
    _labelFileList = [];
    _thumbnailList = {};
    _scrollController ??= ScrollController();
    _themeScrollController ??= ScrollController();
    _faceScrollController ??= ScrollController();
    isInfinityScrollLoading = false;
    mediaLastId = 0;
    labelLastId = 0;
    _selectedLabel = 0;
    index = -1;
    lastDate = "2001-03-01";
    _isLabelLoading = false;

    Map<String, dynamic> mediaInfoResponse = await _albumRepository.getMediaInfoList(mediaLastId, 20);
    if (mediaInfoResponse['result'] == Strings.fail) {
      return;
    }

    List<dynamic> mediaInfoList = jsonDecode(mediaInfoResponse['response']['data'])['album'];
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

    await setAlbumBuildFileList(mediaFileListResponse['response']);

    Map<String, dynamic> faceResponse = await _albumRepository.getFaceList();

    if (faceResponse['result'] == Strings.fail) {
      return;
    }

    _faceDataList = jsonDecode(faceResponse['response']['data']);

    List<dynamic> faceDataMap = [];
    for (Map<dynamic, dynamic> faceData in _faceDataList) {
      faceDataMap.add({'key': faceData['key']});
    }

    if (faceDataMap.isNotEmpty) {
      Map<String, dynamic> mediaFileListResponse = await loadMedia(faceDataMap);
      if (mediaFileListResponse['result'] == Strings.fail) {
        return;
      }

      for (File file in mediaFileListResponse['response']) {
        _faceFileList.add(file);
      }
    }

    Map<String, dynamic> labelResponse = await _albumRepository.getLabelList();

    if (labelResponse['result'] == Strings.fail) {
      return;
    }

    _labelDataList = jsonDecode(labelResponse['response']['data']);

    if (_labelDataList.isNotEmpty) {
      initLabelView(_labelDataList[0]['label']);
    }

    notifyListeners();

    Fluttertoast.showToast(msg: "앨범 성공적으로 불러옴");
  }

  Future initFaceView(int clusterId) async {
    faceLastId = 0;
    _faceDetailFileList = [];
    _faceScrollController ??= ScrollController();

    Map<String, dynamic> faceResponse = await _albumRepository.getFaceDetail(faceLastId, 18, clusterId);

    if (faceResponse['result'] == Strings.fail) {
      return;
    }

    List<dynamic> faceData = jsonDecode(faceResponse['response']['data']);

    if (faceData.isNotEmpty) {
      faceLastId = faceData.last[0];
    } else {
      faceLastId = -1;
    }

    List<dynamic> requestList = [];
    for (List<dynamic> f in faceData) {
      requestList.add({'key': f[1]});
    }

    if (requestList.isNotEmpty) {
      Map<String, dynamic> mediaFileListResponse = await loadMedia(requestList);
      if (mediaFileListResponse['result'] == Strings.fail) {
        return;
      }

      for (File file in mediaFileListResponse['response']) {
        _faceDetailFileList.add(file);
      }
    }

    return;
  }

  Future initLabelView(String labelName) async {
    labelLastId = 0;
    _labelDetailFileList = [];

    _isLabelLoading = true;
    notifyListeners();

    Map<String, dynamic> labelResponse = await _albumRepository.getLabelDetail(labelLastId, 18, labelName);

    if (labelResponse['result'] == Strings.fail) {
      return;
    }

    List<dynamic> labelData = jsonDecode(labelResponse['response']['data']);

    if (labelData.isNotEmpty) {
      labelLastId = labelData.last[0];
    }

    List<dynamic> requestList = [];
    for (List<dynamic> f in labelData) {
      requestList.add({'key': f[1]});
    }

    if (requestList.isNotEmpty) {
      Map<String, dynamic> mediaFileListResponse = await loadMedia(requestList);
      if (mediaFileListResponse['result'] == Strings.fail) {
        return;
      }

      for (File file in mediaFileListResponse['response']) {
        _labelDetailFileList.add(file);
      }
    }

    _isLabelLoading = false;
    notifyListeners();
  }

  void setSelectedLabel(int index) {
    _selectedLabel = index;
    labelLastId = 0;
    notifyListeners();
  }

  /// 미디어 info를 넘기면, 디렉토리에서 찾던 다운하던 로드하고 로드된 파일을 리턴함.
  Future<Map<String, dynamic>> loadMedia(List<dynamic> mediaInfoList) async {
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
    scrollController!.addListener(
      () async {
        if (scrollController!.offset == scrollController!.position.maxScrollExtent &&
            !scrollController!.position.outOfRange) {
          if (isInfinityScrollLoading == true || mediaLastId == -1) {
            return;
          }

          isInfinityScrollLoading = true;

          Map<String, dynamic> mediaInfoResponse = await _albumRepository.getMediaInfoList(
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

          Map<String, dynamic> mediaFileListResponse = await loadMedia(mediaInfoList);
          if (mediaFileListResponse['result'] == Strings.fail) {
            return;
          }

          await setAlbumBuildFileList(mediaFileListResponse['response']);

          notifyListeners();
          isInfinityScrollLoading = false;
        }
      },
    );
  }

  void addThemeScrollListener() {
    themeScrollController!.addListener(
      () async {
        if (themeScrollController!.offset == themeScrollController!.position.maxScrollExtent &&
            !themeScrollController!.position.outOfRange) {
          if (isInfinityScrollLoading == true || labelLastId == -1) {
            return;
          }

          isInfinityScrollLoading = true;

          Map<String, dynamic> labelResponse = await _albumRepository.getLabelDetail(
            labelLastId,
            18,
            _labelDataList[_selectedLabel]['label'],
          );

          if (labelResponse['result'] == Strings.fail) {
            return;
          }

          List<dynamic> labelData = jsonDecode(labelResponse['response']['data']);

          if (labelData.isNotEmpty) {
            labelLastId = labelData.last[0];
          } else {
            labelLastId = -1;
          }

          List<dynamic> requestList = [];
          for (List<dynamic> f in labelData) {
            requestList.add({'key': f[1]});
          }

          if (requestList.isNotEmpty) {
            Map<String, dynamic> mediaFileListResponse = await loadMedia(requestList);
            if (mediaFileListResponse['result'] == Strings.fail) {
              return;
            }

            for (File file in mediaFileListResponse['response']) {
              _labelDetailFileList.add(file);
            }
          }

          notifyListeners();
          isInfinityScrollLoading = false;
        }
      },
    );
  }

  void addFaceScrollListener(int value) {
    faceScrollController!.addListener(
      () async {
        if (faceScrollController!.offset == faceScrollController!.position.maxScrollExtent &&
            !faceScrollController!.position.outOfRange) {
          if (isInfinityScrollLoading == true || faceLastId == -1) {
            return;
          }

          Map<String, dynamic> faceResponse = await _albumRepository.getFaceDetail(faceLastId, 18, value);

          if (faceResponse['result'] == Strings.fail) {
            return;
          }

          List<dynamic> faceData = jsonDecode(faceResponse['response']['data']);

          if (faceData.isNotEmpty) {
            faceLastId = faceData.last[0];
          } else {
            faceLastId = -1;
          }

          print(faceData);

          List<dynamic> requestList = [];
          for (List<dynamic> f in faceData) {
            requestList.add({'key': f[1]});
          }

          if (requestList.isNotEmpty) {
            Map<String, dynamic> mediaFileListResponse = await loadMedia(requestList);
            if (mediaFileListResponse['result'] == Strings.fail) {
              return;
            }

            for (File file in mediaFileListResponse['response']) {
              _faceDetailFileList.add(file);
            }
          }

          isInfinityScrollLoading = false;
          notifyListeners();
        }
      },
    );
  }

  Future setAlbumBuildFileList(List<File> fileList) async {
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

      if (extension(mediaFile.path) == ".mp4") {
        _thumbnailList[basename(mediaFile.path)] = await getVideoThumbnailFile(
          mediaFile,
        );
      }
    }

    notifyListeners();
  }

  clear() {
    _albumBuildFileList = [];
  }
}
