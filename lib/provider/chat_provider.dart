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
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_compress/video_compress.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../constant/strings.dart';
import '../data/datasource/remote_datasource.dart';

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

  /// 채팅창 모드
  late ChatMode _chatMode;
  ChatMode get chatMode => _chatMode;

  /// 모든 앨범 파일 썸네일 용
  final List<File> _thumbnailMedias = [];
  List<File> get thumbnailMedias => _thumbnailMedias;

  /// 선택된 미디어 파일명
  final List<File> _selectedMediaFiles = [];
  List<File> get selectedMediaFiles => _selectedMediaFiles;

  /// 모든 앨범 파일
  final List<File> _mediaFiles = [];
  List<File> get mediaFiles => _mediaFiles;

  ///
  /// [함수]
  ///
  /// 채팅 페이지 빌드 시 초기화 로직들 모음
  Future initial() async {
    isBottom = true;
    _lastChatId = 0;
    _scrollController = ScrollController();
    _chatMode = ChatMode.textInput;

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
          _addChat(
            Chat(
              userId: message['user_id'],
              content: message['content'],
              sendAt: message['send_at'],
              metaData: message['metadata'],
              unReadCount: _disconnectCount,
            ),
          );
        } else if (item.containsKey("connection_data")) {
          var connection = item["connection_data"];
          updateConnection(connection);
        } else {
          log("what?");
        }
      },
    );

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

    /// 현재 connection 불러오기
    Map<String, dynamic> connectionResponse =
        await _chatRepository.getConnections();

    if (connectionResponse[Strings.message] == Strings.fail) {
      Fluttertoast.showToast(msg: "커넥션 불러오기 실패");
      return;
    }

    _disconnectCount = 0;
    for (Map<String, dynamic> connection in connectionResponse['response']
        ['data']) {
      if (connection['memberId'] == _memberId) {
        connection['joining'] = true;
      }
      if (connection['joining'] == false) {
        _disconnectCount++;
      }
      connection['lastJoined'] =
          DateTime.parse(connection['lastJoined']).millisecondsSinceEpoch /
              1000;
      _connections[connection['memberId']] = connection;
    }

    _chats = [];
    List<dynamic> messages = chatResponse['response']['data'];

    if (messages.isEmpty) {
      return;
    }

    _lastChatId = chatResponse['response']['data'][0]['messageId'];

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
    _chats = _chats.reversed.toList();

    updateUnreadCount();
  }

  void updateConnection(Map<String, dynamic> connection) {
    int id = connection['memberId'];
    bool isJoining = connection['joining'];

    if (isJoining) {
      _disconnectCount--;
    } else {
      connection['lastJoined'] =
          DateTime.parse(connection['lastJoined']).millisecondsSinceEpoch /
              1000;
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

  void postPlainChat(BuildContext context, String chat) async {
    isBottom = true;

    _addChat(
      Chat(
        userId: context.read<UserProvider>().me!.memberId,
        content: chat,
        sendAt: DateTime.now().millisecondsSinceEpoch / 1000,
        metaData: {"type_code": "plain"},
        unReadCount: _disconnectCount,
      ),
    );

    Map<String, dynamic> response = await _chatRepository.postChat(chat);

    if (response['message'] == Strings.success) {
    } else {
      /// chat 삭제 로직
    }
  }

  void postMediaFileFromCamera() async {}

  void postMediaFilesFromAlbum() async {
    if (_selectedMediaFiles.isEmpty) {
      return;
    }
    _chatMode = ChatMode.textInput;

    Map<String, dynamic> urlResponse =
        await _chatRepository.getMediaUploadUrl();

    if (urlResponse['message'] == Strings.fail) {
      return;
    }

    Map<String, dynamic> mediaUrlData = jsonDecode(
      urlResponse['response']['data'],
    );

    /// 압축 로직
    await VideoCompress.deleteAllCache();
    Directory? directory = await getExternalStorageDirectory();
    List<File> compressedFiles = [];

    int index = 0;
    for (File file in _selectedMediaFiles) {
      if ([".jpg", ".jpeg"].contains(extension(file.path))) {
        var imageResult = (await FlutterImageCompress.compressAndGetFile(
          file.absolute.path,
          "${directory?.path}/Download/cached_media/messengers/temp$index${extension(file.path)}",
          quality: 30,
        ))!;
        compressedFiles.add(imageResult);
      } else if ([".mp4"].contains(extension(file.path))) {
        var videoResult = ((await VideoCompress.compressVideo(
          file.absolute.path,
          quality: VideoQuality.LowQuality,
          deleteOrigin: false,
          includeAudio: true,
        ))!
            .file!);
        compressedFiles.add(videoResult);
      } else {
        /// .png
        log("이 파일형식 반영 안됨. ${extension(file.path)}");
      }
    }
    log("count -> ${compressedFiles.length}");

    if (compressedFiles.isEmpty) {
      return;
    }

    /// zip으로 묶는 로직
    MultipartFile zipFile = await compressFilesToZip(
      compressedFiles,
    );

    Map<String, dynamic> response = await _chatRepository.uploadMedia(
      MediaUploadDTO(
        mediaUrlData: mediaUrlData,
        file: zipFile,
        type: "zip",
        imageCount: compressedFiles.length,
        memberId: _memberId,
        familyId: _familyId,
      ),
    );

    if (response[Strings.message] == Strings.success) {
      Fluttertoast.showToast(msg: "미디어 전송 성공");
    } else {
      Fluttertoast.showToast(msg: "미디어 전송 실패");
    }

    await VideoCompress.deleteAllCache();
    clearSelectedMedia();
  }

  /// 채팅리스트에 뒤에 추가합니다.
  void _addChat(Chat chat) {
    _chats.insert(0, chat);

    notifyListeners();
  }

  /// 채팅뷰의 scrollController의 listener
  void addScrollListener() {
    scrollController.addListener(
      () async {
        if (scrollController.offset ==
                scrollController.position.minScrollExtent &&
            !scrollController.position.outOfRange) {
          isBottom = true;
        } else {
          isBottom = false;
        }

        if (scrollController.offset ==
                scrollController.position.maxScrollExtent &&
            !scrollController.position.outOfRange) {
          if (isInfinityScrollLoading == true) {
            return;
          }

          isInfinityScrollLoading = true;

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

          if (chatResponse['response']['data'].length == 0) {
            return;
          }

          _lastChatId = chatResponse['response']['data'][0]['messageId'];

          for (Map<String, dynamic> message
              in chatResponse['response']['data'].reversed.toList()) {
            _chats.add(
              Chat(
                userId: message['memberId'],
                content: message['content'],
                sendAt:
                    DateTime.parse(message['sendAt']).millisecondsSinceEpoch /
                        1000,
                metaData: message['metaData'],
                unReadCount: _disconnectCount,
              ),
            );
          }

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
  Future<bool> addMedia(File? mediaFile) async {
    if (mediaFile != null) {
      _mediaFiles.add(mediaFile);
      _thumbnailMedias.add(await getVideoThumbnail(mediaFile));
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

  void setChatMode(ChatMode newChatMode) {
    _chatMode = newChatMode;

    notifyListeners();
  }

  /// 채팅방에서 날갈 때 초기화 해야할 값 초기화
  void refresh() {
    _chatMode = ChatMode.textInput;
    _chats.clear();
  }

  clear() {

  }
}
