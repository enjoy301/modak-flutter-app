import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/enum/chat_enum.dart';
import 'package:modak_flutter_app/models/chat_model.dart';

class ChatProvider extends ChangeNotifier {

  /// 변수 정의
  final List<ChatModel> _chats = [];
  final List<File> _files = [];

  String _currentMyChat = "";
  bool _isFunctionOpened = false;
  FunctionState _functionState = FunctionState.landing;

  /// getters
  List<ChatModel> get chats => _chats;
  List<File> get files => _files;

  String get currentMyChat => _currentMyChat;
  bool get isFunctionOpened => _isFunctionOpened;
  FunctionState get functionState => _functionState;

  /// setters
  void setCurrentMyChat(String chat) {
    _currentMyChat = chat;
  }

  void setIsFunctionOpened (bool isFunctionOpened) {
    _isFunctionOpened = isFunctionOpened;
    notifyListeners();
  }

  /// isFunctionOpened toggle
  void isFunctionOpenedToggle() {
    _isFunctionOpened = !_isFunctionOpened;
    notifyListeners();
  }

  void setFunctionState(FunctionState functionState) {
    _functionState = functionState;
    notifyListeners();
  }

  /// 채팅리스트에 뒤에 추가합니다.
  void add(ChatModel chat) {
    _chats.add(chat);
    notifyListeners();
  }
  void addFile(File file) {
    _files.add(file);
    notifyListeners();
  }

  /// index 번째의 채팅을 가져옵니다.
  ChatModel getChatAt(int index) {
    return chats[index];
  }


  InputState getInputState() {
    /// todo기능, onway기능에서 inputState를 none으로 설정
    if ([FunctionState.todo, FunctionState.onWay].contains(_functionState)) {
      return InputState.none;
    }
    /// album기능에서 inputState를 function으로 설정
    if ([FunctionState.album].contains(_functionState)) {
      return InputState.function;
    }
    return InputState.chat;
  }

  /// 채팅방에서 날갈 때 초기화 해야할 값 초기화
  void refresh() {
    _isFunctionOpened = false;
    _functionState = FunctionState.landing;
    _chats.clear();
  }

}