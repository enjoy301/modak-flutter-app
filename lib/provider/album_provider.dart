import 'dart:io';

import 'package:flutter/material.dart';

class AlbumProvider extends ChangeNotifier {

  static int messengerLastId = 0;

  final List<File> _messengerAlbumFiles = [];
  get messengerAlbumFiles => _messengerAlbumFiles;

  void addFileToMessengerAlbum(File file) {
    _messengerAlbumFiles.add(file);
    notifyListeners();
  }

  File getFileFromMessengerAlbumAt(int index) {
    return _messengerAlbumFiles[index];
  }

  final List<File> _todoAlbumFiles = [];
  get todoAlbumFiles => _todoAlbumFiles;

  void addFileToTodoAlbum(File file) {
    _todoAlbumFiles.add(file);
    notifyListeners();
  }

  File getFileFromTodoAlbumAt(int index) {
    return _todoAlbumFiles[index];
  }

}