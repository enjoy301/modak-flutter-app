import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modak_flutter_app/models/chat_model.dart';

class ChatProvider extends ChangeNotifier {

  /// 변수 정의
  final List<ChatModel> _chats = [];
  String _currentMyChat = "";
  bool _isFunctionOpened = false;
  final List<File> _files = [];

  /// getters
  List<ChatModel> get chats => _chats;
  String get currentMyChat => _currentMyChat;
  bool get isFunctionOpened => _isFunctionOpened;
  List<File> get files => _files;

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

  void refresh() {
    _chats.clear();
  }

}