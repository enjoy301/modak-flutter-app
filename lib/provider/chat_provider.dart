import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modak_flutter_app/constant/enum/chat_enum.dart';
import 'package:modak_flutter_app/data/dto/chat.dart';
import 'package:modak_flutter_app/data/dto/chat/chat_paging_DTO.dart';
import 'package:modak_flutter_app/data/dto/chat/media_upload_DTO.dart';
import 'package:modak_flutter_app/data/repository/chat_repository.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/utils/extension_util.dart';
import 'package:modak_flutter_app/utils/media_util.dart';
import 'package:modak_flutter_app/utils/notification_controller.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:video_compress/video_compress.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../constant/strings.dart';
import '../data/datasource/remote_datasource.dart';
import '../utils/file_system_util.dart';
import 'album_provider.dart';

class ChatProvider extends ChangeNotifier {
  init() async {
    notifyListeners();
  }

  ///
  /// [변수]
  ///
  final ChatRepository _chatRepository = ChatRepository();
  static late String _memberId;
  static late String _familyId;
  static late String _wssURL;

  late List<Chat> _chats = [];
  List<Chat> get chats => _chats;
  late Map<String, Map<dynamic, dynamic>> _connections;
  int _disconnectCount = 0;
  late int _lastChatId;

  late WebSocketChannel _channel;
  WebSocketChannel get channel => _channel;

  late ScrollController _scrollController;
  ScrollController get scrollController => _scrollController;

  late bool _isBottom;
  bool get isBottom => _isBottom;

  bool isInfinityScrollLoading = false;

  String _currentInput = "";
  String get currentInput => _currentInput;

  String _todoTitle = "";
  String get todoTitle => _todoTitle;

  /// 선택된 감정
  String _feel = Strings.none;
  String get feel => _feel;

  /// 감정 채팅 토글
  bool _feelMode = false;
  bool get feelMode => _feelMode;

  /// 채팅창 모드
  late ChatMode _chatMode;
  ChatMode get chatMode => _chatMode;

  /// 선택된 미디어 파일명
  late List<File> _selectedMediaFiles = [];
  List<File> get selectedMediaFiles => _selectedMediaFiles;

  /// 모든 앨범 파일
  late List<File> _albumFiles;
  List<File> get albumFiles => _albumFiles;

  /// 앨범의 동영상 썸네일
  late Map<String, File> _thumbnailFiles;
  Map<String, File> get thumbnailFiles => _thumbnailFiles;

  late String _mediaDirectory;
  String get mediaDirectory => _mediaDirectory;

  late bool _isDownButtonShow;
  bool get isDownButtonShow => _isDownButtonShow;

  late double _screenHeight;

  ///
  /// [함수]
  ///

  /// 채팅 페이지 빌드 시 초기화 로직들 모음
  Future initial(BuildContext context) async {
    _connections = {};
    _isBottom = true;
    _isDownButtonShow = false;
    _lastChatId = 0;
    _scrollController = ScrollController();
    _chatMode = ChatMode.textInput;
    _chats = [];
    _albumFiles = [];
    _selectedMediaFiles = [];
    _thumbnailFiles = {};
    _mediaDirectory = await FileSystemUtil.getMediaDirectory();
    _screenHeight = MediaQuery.of(context).size.height;

    _memberId = (await RemoteDataSource.storage.read(key: Strings.memberId))!;
    _familyId = (await RemoteDataSource.storage.read(key: Strings.familyId))!;
    _wssURL = "wss://ws.modak-talk.com?family-id=$_familyId&user-id=$_memberId";

    _channel = IOWebSocketChannel.connect(
      Uri.parse(_wssURL),
      pingInterval: Duration(minutes: 9),
    );

    _channel.stream.listen(
      (event) {
        var item = jsonDecode(event) as Map;

        if (item.containsKey("message_data")) {
          Map<String, dynamic> message = item["message_data"];
          if (message['metadata']['type_code'] == 'image' ||
              message['metadata']['type_code'] == 'video') {
            for (Chat chat in _chats) {
              if (chat.metaData!['step'].toString() ==
                  message['metadata']['step'].toString()) {
                _chats.remove(chat);
                break;
              }
            }
          }

          addNewChat(
            Chat(
              userId: message['user_id'],
              content: message['content'],
              sendAt: message['send_at'],
              metaData: message['metadata'],
              unReadCount: _disconnectCount,
            ),
            context,
          );
        } else if (item.containsKey("connection_data")) {
          var connection = item["connection_data"];
          updateConnection(connection);
        }
      },
    );

    /// 현재 connection 불러오기
    Map<String, dynamic> connectionResponse =
        await _chatRepository.getConnections();

    if (connectionResponse[Strings.message] == Strings.fail) {
      Fluttertoast.showToast(msg: "커넥션 불러오기 실패");
      return;
    }

    _disconnectCount = 0;
    for (String uid in connectionResponse['response']['data'].keys) {
      final Map<dynamic, dynamic> connection =
          connectionResponse['response']['data'][uid];

      if (uid == _memberId) {
        connection['joining'] = true;
      } else {
        if (connection['joining'] == false) {
          _disconnectCount++;
        }
      }
      connection['lastJoined'] =
          DateTime.parse(connection['lastJoined']).millisecondsSinceEpoch /
                  1000 +
              32400;
      _connections[uid] = connection;
    }

    await Future(() => updateChat(context));

    updateUnreadCount();
  }

  void updateChat(BuildContext context) async {
    Map<String, dynamic> chatResponse = await _chatRepository.getChats(
      ChatPagingDTO(
        count: 30,
        lastId: _lastChatId,
      ),
    );

    if (chatResponse[Strings.message] == Strings.fail) {
      Fluttertoast.showToast(msg: "채팅 목록 불러오기 실패");
      return;
    }

    List<dynamic> messages = chatResponse['response']['data'];

    if (messages.isEmpty) {
      return;
    }

    _lastChatId = chatResponse['response']['data'][0]['messageId'];

    List<Map<String, String>> mediaKeyList = [];
    for (Map<String, dynamic> message in messages) {
      if (["image", "video"].contains(message['metaData']['type_code'])) {
        for (String key in message['metaData']['key']) {
          mediaKeyList.add({'key': key});
        }
      }
    }

    if (mediaKeyList.isNotEmpty) {
      await Future(() => context.read<AlbumProvider>().loadMedia(mediaKeyList));

      for (Map mediaKey in mediaKeyList) {
        if (mediaKey['key'].toString().toLowerCase().endsWith("mp4") ||
            mediaKey['key'].toString().toLowerCase().endsWith("mov")) {
          _thumbnailFiles[mediaKey['key'].split('/')[2]] =
              await getVideoThumbnailFile(
            File("$_mediaDirectory/${mediaKey['key']}"),
          );
        }
      }
    }

    messages = messages.reversed.toList();
    for (Map<String, dynamic> message in messages) {
      _chats.add(
        Chat(
          userId: message['memberId'],
          content: message['content'],
          sendAt:
              DateTime.parse(message['sendAt']).millisecondsSinceEpoch / 1000,
          metaData: message['metaData'],
          unReadCount: _disconnectCount,
        ),
      );
    }
  }

  void updateConnection(Map<String, dynamic> connection) {
    int id = connection['memberId'];
    bool isJoining = connection['joining'];

    if (isJoining) {
      _disconnectCount--;
    } else {
      connection['lastJoined'] =
          DateTime.parse(connection['lastJoined']).millisecondsSinceEpoch /
                  1000 +
              32400;
      _disconnectCount++;
    }
    _connections[id.toString()] = connection;

    updateUnreadCount();
  }

  void updateUnreadCount() {
    for (Chat chat in _chats) {
      int unReadCount = 0;
      for (dynamic connection in _connections.values) {
        if (connection['joining']) {
          continue;
        }

        if (chat.sendAt > connection['lastJoined']) {
          unReadCount++;
        }
      }
      chat.unReadCount = unReadCount;
    }

    notifyListeners();
  }

  void postChat(BuildContext context, String chat, {Map? metaData}) async {
    _isBottom = true;

    addNewChat(
      Chat(
        userId: context.read<UserProvider>().me!.memberId,
        content: chat,
        sendAt: DateTime.now().millisecondsSinceEpoch / 1000,
        metaData: metaData ?? {"type_code": "plain"},
        unReadCount: _disconnectCount,
      ),
      context,
    );

    Map<String, dynamic> response =
        await _chatRepository.postChat(chat, metaData: metaData);

    if (response['message'] == Strings.fail) {
      _chats.removeAt(0);
      notifyListeners();

      Fluttertoast.showToast(msg: "채팅 보내기 실패");
    } else {
      switch (metaData?['type_code']) {
        default:
          NotificationController.sendNotification("메시지가 도착했습니다 ", chat, "chat");
      }
    }
  }

  void postMediaFiles(BuildContext context, {bool isLocal = false}) async {
    if (_selectedMediaFiles.isEmpty) {
      return;
    }

    if (isLocal) {
      _thumbnailFiles[_selectedMediaFiles[0].path.split('/').last] =
          await getVideoThumbnailFile(
        _selectedMediaFiles[0],
      );
    }

    int imageRandom = 0;
    List<int> videoRandomList = [];

    for (File file in _selectedMediaFiles) {
      if (imageRandom == 0 && file.isImage()) {
        imageRandom = math.Random().nextInt(math.pow(10, 9).toInt()) + 1;
        addNewChat(
          Chat(
            userId: _memberId as int,
            content: file.path,
            sendAt: DateTime.now().millisecondsSinceEpoch / 1000,
            metaData: {
              "type_code": "loading",
              "step": imageRandom,
            },
            unReadCount: _disconnectCount,
          ),
          context,
        );
        notifyListeners();
      }
      if (file.isVideo()) {
        int random = math.Random().nextInt(math.pow(10, 6).toInt()) + 1;
        addNewChat(
          Chat(
            userId: context.read<UserProvider>().me!.memberId,
            content: file.path,
            sendAt: DateTime.now().millisecondsSinceEpoch / 1000,
            metaData: {
              "type_code": "loading",
              "step": random,
            },
            unReadCount: _disconnectCount,
          ),
          context,
        );
        videoRandomList.add(random);
        notifyListeners();
      }
    }

    /// 로직 전 작업
    _chatMode = ChatMode.textInput;

    /// 로직 작업
    Map<String, dynamic> urlResponse =
        await _chatRepository.getMediaUploadUrl();
    if (urlResponse['message'] == Strings.success) {
      Map<String, dynamic> mediaUrlData =
          jsonDecode(urlResponse['response']['data']);

      /// 압축 로직
      List<File> compressedImageFiles = [];
      List<File> compressedVideoFiles = [];

      int index = 0;
      for (File file in _selectedMediaFiles) {
        String fileExt = extension(file.path);

        if (["jpg", "jpeg", "png"].contains(file.path.mediaType())) {
          CompressFormat compressFormat = CompressFormat.jpeg;

          if (fileExt == '.png') {
            compressFormat = CompressFormat.png;
          }

          var imageResult = (await FlutterImageCompress.compressAndGetFile(
            format: compressFormat,
            file.absolute.path,
            "$_mediaDirectory/temp$index$fileExt",
            quality: 30,
          ));
          compressedImageFiles.add(imageResult!);
          index++;
        } else if (file.path.mediaType() == "mp4" ||
            file.path.mediaType() == "mov") {
          await VideoCompress.setLogLevel(0);

          var videoResult = (await VideoCompress.compressVideo(
            file.absolute.path,
            quality: VideoQuality.DefaultQuality,
            deleteOrigin: false,
            includeAudio: true,
          ))!
              .file!;
          compressedVideoFiles.add(videoResult);
        } else {
          Fluttertoast.showToast(
              msg: "지원하지 않는 파일 형식입니다. ${extension(file.path)}");
        }
      }

      if (compressedImageFiles.isNotEmpty) {
        MultipartFile zipFile = await mediaFilesToZip(
          compressedImageFiles,
        );

        Map<String, dynamic> response = await _chatRepository.uploadMedia(
          MediaUploadDTO(
            mediaUrlData: mediaUrlData,
            file: zipFile,
            type: "zip",
            imageCount: compressedImageFiles.length,
            memberId: _memberId,
            familyId: _familyId,
          ),
          imageRandom,
        );

        if (response[Strings.message] == Strings.success) {
          Fluttertoast.showToast(msg: "미디어 전송 성공");
        } else {
          Fluttertoast.showToast(msg: "미디어 전송 실패");
        }
      }

      if (compressedVideoFiles.isNotEmpty) {
        int idx = 0;
        for (File video in compressedVideoFiles) {
          MultipartFile zipFile = await mediaFilesToZip(
            [video],
          );

          Map<String, dynamic> response = await _chatRepository.uploadMedia(
            MediaUploadDTO(
              mediaUrlData: mediaUrlData,
              file: zipFile,
              type: "zip",
              imageCount: 1,
              memberId: _memberId,
              familyId: _familyId,
            ),
            videoRandomList[idx],
          );
          idx += 1;

          if (response[Strings.message] == Strings.success) {
            Fluttertoast.showToast(msg: "미디어 전송 성공");
          } else {
            Fluttertoast.showToast(msg: "미디어 전송 실패");
          }
        }
      }

      await VideoCompress.deleteAllCache();
    }

    clearSelectedMedia();
  }

  /// 채팅리스트에 앞에 추가합니다.
  void addNewChat(Chat chat, BuildContext context) async {
    if (chat.metaData!['type_code'] == 'image' ||
        chat.metaData!['type_code'] == 'video') {
      List<Map<String, String>> mediaKeyList = [];
      for (String key in chat.metaData!['key']) {
        mediaKeyList.add({"key": key});
      }
      if (mediaKeyList.isNotEmpty) {
        await context.read<AlbumProvider>().loadMedia(mediaKeyList);

        if ((mediaKeyList[0]["key"])!.mediaType() == "mp4" ||
            (mediaKeyList[0]["key"])!.mediaType() == "mov") {
          _thumbnailFiles[mediaKeyList[0]["key"]!.split('/')[2]] =
              await getVideoThumbnailFile(
            File("$_mediaDirectory/${mediaKeyList[0]["key"]!}"),
          );
        }
      }
    }

    _chats.insert(0, chat);
    notifyListeners();
  }

  File getThumbnail(String key) {
    return File("$_mediaDirectory/$key");
  }

  List<File> getMediaFiles(List<dynamic> keys) {
    List<File> fileList = [];

    for (dynamic key in keys) {
      fileList.add(File("$_mediaDirectory/${key as String}"));
    }

    return fileList;
  }

  /// 채팅뷰의 scrollController의 listener
  void addScrollListener(BuildContext context) {
    scrollController.addListener(
      () async {
        /// 채팅 아래 계속 붙어 있는 state 관리
        if (scrollController.offset ==
                scrollController.position.minScrollExtent &&
            !scrollController.position.outOfRange) {
          _isBottom = true;
        } else {
          _isBottom = false;
        }

        /// infinity scroll
        if (scrollController.offset ==
                scrollController.position.maxScrollExtent &&
            !scrollController.position.outOfRange) {
          if (isInfinityScrollLoading == true) {
            return;
          }

          isInfinityScrollLoading = true;

          await Future(() => updateChat(context));

          notifyListeners();

          isInfinityScrollLoading = false;
        }

        if (_isDownButtonShow) {
          if (scrollController.offset <= 0) {
            _isDownButtonShow = false;
            notifyListeners();
          }
        } else {
          if (scrollController.offset > (_screenHeight / 2)) {
            _isDownButtonShow = true;
            notifyListeners();
          }
        }
      },
    );
  }

  void setIsBottom(bool isBot) {
    _isBottom = isBot;
    notifyListeners();
  }

  void setCurrentInput(String input) {
    _currentInput = input;
    notifyListeners();
  }

  /// 앨범 리스트 뒤에 미디어와 썸네일 미디어를 추가합니다
  Future<bool> loadAlbum(List<File> mediaFile) async {
    _albumFiles = mediaFile;

    for (File file in _albumFiles) {
      if (file.path.toLowerCase().endsWith('mp4') ||
          file.path.toLowerCase().endsWith('mov')) {
        _thumbnailFiles[basename(file.path)] = await getVideoThumbnailFile(
          file,
        );
      }
    }

    notifyListeners();
    return true;
  }

  /// 선택된 앨범 리스트를 추가합니다
  void addSelectedMedia(File file) {
    _selectedMediaFiles.add(file);
    notifyListeners();
  }

  bool isExistFile(File file) {
    return _selectedMediaFiles.contains(file);
  }

  /// 선택된 앨범 리스트에서 특정 미디어를 제거합니다
  void removeSelectedMedia(File file) {
    _selectedMediaFiles.remove(file);

    notifyListeners();
  }

  /// 선택 앨범을 모두 제거합니다
  void clearSelectedMedia() {
    _selectedMediaFiles.clear();

    notifyListeners();
  }

  set todoTitle(String todoTitle) {
    _todoTitle = todoTitle;
    notifyListeners();
  }

  set feel(String feel) {
    _feel = feel;
    notifyListeners();
  }

  set feelMode(bool feelMode) {
    _feelMode = feelMode;
    _chatMode = ChatMode.textInput;
    notifyListeners();
  }

  set chatMode(ChatMode chatMode) {
    _chatMode = chatMode;
    if (chatMode != ChatMode.textInput) {
      _feelMode = false;
    }
    notifyListeners();
  }

  /// 채팅방에서 날갈 때 초기화 해야할 값 초기화
  void refresh() {
    _chatMode = ChatMode.textInput;
    _chats.clear();
  }

  void clear() {}
}
