import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modak_flutter_app/constant/enum/chat_enum.dart';
import 'package:modak_flutter_app/models/chat_model.dart';
import 'package:modak_flutter_app/utils/media_util.dart';

class ChatProvider extends ChangeNotifier {

  /// PREFIX: 채팅

  /// 모든 채팅
  final List<ChatModel> _chats = [];
  List<ChatModel> get chats => _chats;

  /// 채팅리스트에 뒤에 추가합니다.
  void addChat(ChatModel chat) {
    _chats.add(chat);
    notifyListeners();
  }

  /// index 번째의 채팅을 가져옵니다.
  ChatModel getChatAt(int index) {
    return chats[index];
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
    print(_medias.length);
    print(_thumbnailMedias.length);
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

  void setIsFunctionOpened (bool isFunctionOpened) {
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
    _isEmotionOpened  = !_isEmotionOpened;
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