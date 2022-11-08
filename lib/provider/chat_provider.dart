import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

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
import 'package:modak_flutter_app/utils/media_util.dart';
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
    clear();
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
  final Map<int, Map<String, dynamic>> _connections = {};
  int _disconnectCount = 0;
  late int _lastChatId;

  late WebSocketChannel _channel;
  WebSocketChannel get channel => _channel;

  late ScrollController _scrollController;
  ScrollController get scrollController => _scrollController;
  late bool isBottom;
  bool isInfinityScrollLoading = false;

  String _currentInput = "";
  String get currentInput => _currentInput;

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
  final List<File> _selectedMediaFiles = [];
  List<File> get selectedMediaFiles => _selectedMediaFiles;

  /// 모든 앨범 파일
  late List<File> _albumFiles;
  List<File> get albumFiles => _albumFiles;

  /// 앨범의 동영상 썸네일
  late Map<String, File> _albumThumbnailFiles;
  Map<String, File> get albumThumbnailFiles => _albumThumbnailFiles;

  /// 채팅의 동영상 썸네일
  late Map<String, File> _chatThumbnailFiles;
  Map<String, File> get chatThumbnailFiles => _chatThumbnailFiles;

  late String _mediaDirectory;
  String get mediaDirectory => _mediaDirectory;

  ///
  /// [함수]
  ///

  /// 채팅 페이지 빌드 시 초기화 로직들 모음
  Future initial(BuildContext context) async {
    isBottom = true;
    _lastChatId = 0;
    _scrollController = ScrollController();
    _chatMode = ChatMode.textInput;
    _chats = [];
    _albumFiles = [];
    _albumThumbnailFiles = {};
    _chatThumbnailFiles = {};
    _mediaDirectory = await FileSystemUtil.getMediaDirectory();

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
    Map<String, dynamic> connectionResponse = await _chatRepository.getConnections();

    if (connectionResponse[Strings.message] == Strings.fail) {
      Fluttertoast.showToast(msg: "커넥션 불러오기 실패");
      return;
    }

    _disconnectCount = 0;
    for (Map<String, dynamic> connection in connectionResponse['response']['data']) {
      if (connection['memberId'] == _memberId) {
        connection['joining'] = true;
      }
      if (connection['joining'] == false) {
        _disconnectCount++;
      }
      connection['lastJoined'] = DateTime.parse(connection['lastJoined']).millisecondsSinceEpoch / 1000;
      _connections[connection['memberId']] = connection;
    }

    await Future(() => updateChat(context));

    updateUnreadCount();
  }

  void updateChat(BuildContext context) async {
    /// 채팅 목록 불러오기
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
        if (mediaKey['key'].endsWith('mp4')) {
          _chatThumbnailFiles[mediaKey['key']] = await getVideoThumbnailFile(
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
          sendAt: DateTime.parse(message['sendAt']).millisecondsSinceEpoch / 1000,
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
      connection['lastJoined'] = DateTime.parse(connection['lastJoined']).millisecondsSinceEpoch / 1000;
      _disconnectCount++;
    }
    _connections[id] = connection;

    updateUnreadCount();
  }

  void updateUnreadCount() {
    for (Chat chat in _chats) {
      int unReadCount = 0;
      for (dynamic connection in _connections.values) {
        if (connection['joining']) {
          continue;
        }

        /// 현재 접속 중이 아니면서 && chat 보낸 시점보다 lastJoined가 더 작을 때 (더 옛날)
        if (chat.sendAt > connection['lastJoined']) {
          unReadCount++;
        }
      }
      chat.unReadCount = unReadCount;
    }

    notifyListeners();
  }

  void postChat(BuildContext context, String chat, {Map? metaData}) async {
    isBottom = true;

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

    Map<String, dynamic> response = await _chatRepository.postChat(chat, metaData: metaData);

    if (response['message'] == Strings.fail) {
      _chats.removeAt(0);
      notifyListeners();

      Fluttertoast.showToast(msg: "채팅 보내기 실패");
    }
  }

  void postMediaFileFromCamera(
    File file,
    String type,
  ) async {
    List<File> compressedFiles = [];
    if (type == "jpg") {
      var imageResult = (await FlutterImageCompress.compressAndGetFile(
        file.path,
        "$_mediaDirectory/temp0.jpg",
        quality: 30,
      ))!;
      compressedFiles.add(imageResult);
    } else if (type == "mp4") {
      var videoResult = ((await VideoCompress.compressVideo(
        file.path,
        quality: VideoQuality.LowQuality,
        deleteOrigin: false,
        includeAudio: true,
      ))!
          .file!);
      compressedFiles.add(videoResult);
    }
    MultipartFile zipFile = await mediaFilesToZip(
      compressedFiles,
    );

    Map<String, dynamic> urlResponse = await _chatRepository.getMediaUploadUrl();

    if (urlResponse['message'] == Strings.fail) {
      return;
    }

    Map<String, dynamic> mediaUrlData = jsonDecode(
      urlResponse['response']['data'],
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
    );

    if (response[Strings.message] == Strings.success) {
      Fluttertoast.showToast(msg: "미디어 전송 성공");
    } else {
      Fluttertoast.showToast(msg: "미디어 전송 실패");
    }
  }

  void postMediaFilesFromAlbum() async {
    if (_selectedMediaFiles.isEmpty) {
      return;
    }

    /// 로직 전 작업
    _chatMode = ChatMode.textInput;
    // 채팅 임의로 만들기
    notifyListeners();

    /// 로직 작업
    Map<String, dynamic> urlResponse = await _chatRepository.getMediaUploadUrl();
    if (urlResponse['message'] == Strings.success) {
      Map<String, dynamic> mediaUrlData = jsonDecode(urlResponse['response']['data']);

      /// 압축 로직
      List<File> compressedImageFiles = [];
      List<File> compressedVideoFiles = [];

      int index = 0;
      for (File file in _selectedMediaFiles) {
        String fileExt = extension(file.path);

        if ([".jpg", ".jpeg", ".png"].contains(extension(file.path))) {
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
        } else if (extension(file.path) == ".mp4") {
          var videoResult = (await VideoCompress.compressVideo(
            file.absolute.path,
            quality: VideoQuality.LowQuality,
            deleteOrigin: false,
            includeAudio: true,
          ))!
              .file!;
          compressedVideoFiles.add(videoResult);
        } else {
          log("이 파일형식 반영 안됨. ${extension(file.path)}");
          log(file.path);
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
        );

        if (response[Strings.message] == Strings.success) {
          Fluttertoast.showToast(msg: "미디어 전송 성공");
        } else {
          Fluttertoast.showToast(msg: "미디어 전송 실패");
        }
      }

      if (compressedVideoFiles.isNotEmpty) {
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
          );

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
    if (chat.metaData!['type_code'] == 'image' || chat.metaData!['type_code'] == 'video') {
      List<Map<String, String>> mediaKeyList = [];
      for (String key in chat.metaData!['key']) {
        mediaKeyList.add({"key": key});
      }
      if (mediaKeyList.isNotEmpty) {
        await context.read<AlbumProvider>().loadMedia(mediaKeyList);

        if ((mediaKeyList[0]["key"])!.endsWith('.mp4')) {
          _chatThumbnailFiles[mediaKeyList[0]["key"]!] = await getVideoThumbnailFile(
            File(
              "$_mediaDirectory/${mediaKeyList[0]["key"]!}",
            ),
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
      log("$key");
      fileList.add(File("$_mediaDirectory/${key as String}"));
    }

    return fileList;
  }

  /// 채팅뷰의 scrollController의 listener
  void addScrollListener(BuildContext context) {
    scrollController.addListener(
      () async {
        /// 채팅 아래 계속 붙어 있는 state 관리
        if (scrollController.offset == scrollController.position.minScrollExtent &&
            !scrollController.position.outOfRange) {
          isBottom = true;
        } else {
          isBottom = false;
        }

        /// infinity scroll
        if (scrollController.offset == scrollController.position.maxScrollExtent &&
            !scrollController.position.outOfRange) {
          if (isInfinityScrollLoading == true) {
            return;
          }

          isInfinityScrollLoading = true;

          await Future(() => updateChat(context));

          notifyListeners();

          isInfinityScrollLoading = false;
        }
      },
    );
  }

  void setCurrentInput(String input) {
    _currentInput = input;
    notifyListeners();
  }

  /// 앨범 리스트 뒤에 미디어와 썸네일 미디어를 추가합니다
  Future<bool> loadAlbum(List<File> mediaFile) async {
    _albumFiles = mediaFile;

    for (File file in _albumFiles) {
      if (file.path.endsWith('mp4')) {
        _albumThumbnailFiles[basename(file.path)] = await getVideoThumbnailFile(
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

  clear() {}
}
