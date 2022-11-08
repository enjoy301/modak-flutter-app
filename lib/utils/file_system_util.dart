import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileSystemUtil {
  static Future<String> getMediaDirectory() async {
    Directory? directory = await getApplicationDocumentsDirectory();

    if (!Directory("${directory.path}/Download/cached_media/messengers").existsSync()) {
      Directory("${directory.path}/Download/cached_media/messengers").create(
        recursive: true,
      );
    }
    return Directory("${directory.path}/Download/cached_media/messengers").path;
  }
}
