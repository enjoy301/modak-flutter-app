import 'dart:io';

import 'package:flutter/material.dart';

class AlbumProvider extends ChangeNotifier {
  static int messengerLastId = 0;

  List<File> _messengerAlbumFiles = [];
  get messengerAlbumFiles => _messengerAlbumFiles;
  File? _messengerThumbnail;
  get messengerThumbnail => _messengerThumbnail;

  void setFileToMessengerAlbum(List<File> fileList) {
    _messengerAlbumFiles = [];

    if (fileList.isNotEmpty) {
      _messengerThumbnail = fileList[0];

      for (File file in fileList) {
        _messengerAlbumFiles.add(file);
      }

      notifyListeners();
    }
  }

  File getFileFromMessengerAlbumAt(int index) {
    return _messengerAlbumFiles[index];
  }

  final List<File> _todoAlbumFiles = [];
  get todoAlbumFiles => _todoAlbumFiles;
  File? _todoThumbnail;
  get todoThumbnail => _todoThumbnail;

  void addFileToTodoAlbum(File file) {
    _todoAlbumFiles.add(file);
    notifyListeners();
  }

  File getFileFromTodoAlbumAt(int index) {
    return _todoAlbumFiles[index];
  }
}
