import 'dart:io';

import 'package:flutter/material.dart';

class AlbumProvider extends ChangeNotifier {

  final List<File> _messengerAlbumFiles = [File("storage/emulated/0/Android/data/com.example.modak_flutter_app/files/Download/cached_media/test.png")];
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