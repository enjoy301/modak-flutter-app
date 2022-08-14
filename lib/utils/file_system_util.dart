import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modak_flutter_app/provider/album_provider.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class FileSystemUtil {
  static Future<Directory?> getMediaDirectory() async {
    Directory? directory = await getExternalStorageDirectory();

    if (directory == null) {
      return null;
    }

    return Directory("${directory.path}/Download/cached_media/messengers");
  }

  static Future<void> loadMediaOnMemory(BuildContext context) async {
    Directory? directory = await FileSystemUtil.getMediaDirectory();
    if (directory != null) {
      Directory messengerDirectory =
      Directory("${directory.path}/${UserProvider.family_id}");
      Directory todoDirectory =
      Directory("${directory.path}/${UserProvider.family_id}");

      if (!await messengerDirectory.exists()) {
    await messengerDirectory.create(recursive: true);
    }

    if (!await todoDirectory.exists()) {
    await todoDirectory.create(recursive: true);
    }

    List<FileSystemEntity> messengerFiles =
    messengerDirectory.listSync(recursive: true);
    List<FileSystemEntity> todoFiles =
    todoDirectory.listSync(recursive: true);

    List<File> fileList = [];
    for (FileSystemEntity fileSystemEntity in messengerFiles) {
    fileList.add(File(fileSystemEntity.path));
    }
    Future(() => context.read<AlbumProvider>().setFileToMessengerAlbum(fileList));

    // for (FileSystemEntity fileSystemEntity in todoFiles) {
    //   // ignore: use_build_context_synchronously
    //   context.read<AlbumProvider>().addFileToTodoAlbum(File(fileSystemEntity.path));
    // }
  }
  }
}
