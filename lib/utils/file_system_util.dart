import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileSystemUtil {
  static Future<Directory?> getMediaDirectory() async {
    Directory? directory =  await getExternalStorageDirectory();
    if (directory == null) {
      return null;
    }
    directory = Directory("${directory.path}/Download/cached_media/messengers");
    return directory;
  }
}