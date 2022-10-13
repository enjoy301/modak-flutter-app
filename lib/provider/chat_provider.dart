import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modak_flutter_app/constant/enum/chat_enum.dart';
import 'package:modak_flutter_app/data/datasource/remote_datasource.dart';
import 'package:modak_flutter_app/data/dto/chat.dart';
import 'package:modak_flutter_app/data/repository/chat_repository.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/utils/media_util.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../constant/strings.dart';

class ChatProvider extends ChangeNotifier {
  init() async {
    _chatRepository = ChatRepository();
  }

  static late final ChatRepository _chatRepository;

  /// PREFIX: 채팅
  late List<Chat> _chats = [];
  List<Chat> get chats => _chats;

  late WebSocketChannel _channel;
  WebSocketChannel get channel => _channel;

  final Map<int, Map<String, dynamic>> _connections = {};
  int _disconnectCount = 0;

  // 웹 소켓 연결, chat 호출 connection 호출
  void initial(BuildContext context) async {
    _channel = IOWebSocketChannel.connect(
      "wss://ws.modak-talk.com?family-id=${await RemoteDataSource.storage.read(key: Strings.familyId)}&user-id=${context.read<UserProvider>().me!.memberId}",
      pingInterval: Duration(minutes: 9),
    );

    _channel.stream.listen(
      (event) {
        var item = jsonDecode(event) as Map;
        log("message -> $item");
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
    Map<String, dynamic> chatResponse = await _chatRepository.getChats(30, 0);

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

    int memberId =
        await Future(() => context.read<UserProvider>().me!.memberId);

    _disconnectCount = 0;
    for (Map<String, dynamic> connection in connectionResponse['response']
        ['data']) {
      if (connection['memberId'] == memberId) {
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
    updateUnreadCount();
  }

  /// PREFIX: 커넥션 관리
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

        // log("${chat.content} chat: ${chat.sendAt} conn: ${connection['lastJoined']} connid: ${connection['memberId']} / chat이 크다! ${chat.sendAt > connection['lastJoined']}");

        /// 현재 접속 중이 아니면서 && chat 보낸 시점보다 lastJoined가 더 작을 때 (더 옛날)
        if (chat.sendAt > connection['lastJoined']) {
          unReadCount++;
        }
      }
      chat.unReadCount = unReadCount;
    }

    notifyListeners();
  }

  void postChat(BuildContext context, String chat) async {
    log("${DateTime.now().millisecondsSinceEpoch / 1000}");
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
  }

  void postMedia(
    MultipartFile? file,
    String type,
    int imageCount,
  ) async {
    Map<String, dynamic> getMediaUrlResponse =
        await _chatRepository.getMediaUrl();
    Map<String, dynamic> mediaUrlData =
        jsonDecode(getMediaUrlResponse['response'].data);

    Map<String, dynamic> uploadMediaResponse = await _chatRepository
        .uploadMedia(mediaUrlData, file!, type, imageCount, "1", "1");
  }

  /// 채팅리스트에 뒤에 추가합니다.
  void _addChat(Chat chat) {
    _chats.add(chat);
    notifyListeners();
  }

  /// 내가 작성중인 채팅
  String _currentMyChat = "";
  String get currentMyChat => _currentMyChat;

  void setCurrentMyChat(String chat) {
    _currentMyChat = chat;
    notifyListeners();
  }

  /// 내가 작성중인 채팅 상태
  ChatType _currentMyChatType = ChatType.general;
  ChatType get currentMyChatType => _currentMyChatType;

  void setCurrentMyChatType(ChatType currentMyChatType) {
    _currentMyChatType = currentMyChatType;
  }

  ///

  /// PREFIX: 앨범 사진 보관

  /// 모든 앨범 파일
  final List<File> _medias = [];
  List<File> get medias => _medias;

  /// 앨범 리스트 뒤에 미디어와 썸네일 미디어를 추가합니다
  Future<bool> addMedia(File? media) async {
    if (media != null) {
      _medias.add(media);
      _thumbnailMedias.add(await getVideoThumbnail(media));
    }
    notifyListeners();
    return true;
  }

  /// index 번째의 미디어를 가져옵니다
  File getMediaAt(int index) {
    return _medias[index];
  }

  /// 모든 앨범 파일 썸네일 용
  final List<File> _thumbnailMedias = [];
  List<File> get thumbnailMedias => _thumbnailMedias;

  /// index 번째의 썸네일 미디어를 가져옵니다
  File getThumbnailMediaAt(int index) {
    return _thumbnailMedias[index];
  }

  /// 선택된 앨범 index
  final List<File> _selectedMedias = [];
  List<File> get selectedMedias => _selectedMedias;

  /// 선택된 앨범 리스트를 추가합니다
  void addSelectedMedia(File file) {
    _selectedMedias.add(file);
    notifyListeners();
  }

  /// 선택된 앨범 리스트에서 특정 미디어를 제거합니다
  bool removeSelectedMedia(File file) {
    bool isExist = _selectedMedias.remove(file);
    notifyListeners();
    return isExist;
  }

  /// 선택 앨범을 모두 제거합니다
  void clearSelectedMedia() {
    _selectedMedias.clear();
    notifyListeners();
  }

  /// PREFIX: 입력 칸, 기능 칸 상태

  /// 기능 창 열림 여부
  bool _isFunctionOpened = false;
  bool get isFunctionOpened => _isFunctionOpened;

  void setIsFunctionOpened(bool isFunctionOpened) {
    _isFunctionOpened = isFunctionOpened;
    notifyListeners();
  }

  void isFunctionOpenedToggle() {
    _isFunctionOpened = !_isFunctionOpened;
    notifyListeners();
  }

  /// 기능 창 상태
  FunctionState _functionState = FunctionState.landing;
  FunctionState get functionState => _functionState;

  void setFunctionState(FunctionState functionState) {
    _functionState = functionState;
    notifyListeners();
  }

  /// 기능 창 상태를 기반으로 입력 칸 상태를 결정함
  InputState getInputState() {
    /// todo상태, onway상태에서 inputState를 none으로 설정
    if ([FunctionState.todo, FunctionState.onWay].contains(_functionState)) {
      return InputState.none;
    }

    /// album기능에서 inputState를 function으로 설정
    if ([FunctionState.album].contains(_functionState)) {
      return InputState.function;
    }

    /// 그 외 상태에서 inputState를 chat으로 설정
    return InputState.chat;
  }

  /// PREFIX: 감정 상태 칸
  bool _isEmotionOpened = false;
  bool get isEmotionOpened => _isEmotionOpened;

  void setIsEmotionOpened(bool isEmotionOpened) {
    _isEmotionOpened = isEmotionOpened;
    notifyListeners();
  }

  void toggleIsEmotionOpened() {
    _isEmotionOpened = !_isEmotionOpened;
    notifyListeners();
  }

  /// 채팅방에서 날갈 때 초기화 해야할 값 초기화
  /// TODO refresh 추가 및 정리
  void refresh() {
    _isFunctionOpened = false;
    _functionState = FunctionState.landing;
    _chats.clear();
  }
}
