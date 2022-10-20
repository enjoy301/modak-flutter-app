import 'dart:developer';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modak_flutter_app/utils/extension_util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

Future<File> getImageFromCamera() async {
  try {
    File file = File((await ImagePicker().pickImage(
      source: ImageSource.camera,
    ))!
        .path);

    return file;
  } catch (e) {
    log("failed to get image, $e");
    return File("");
  }
}

Future<File> getVideoFromCamera() async {
  try {
    File file = File((await ImagePicker().pickVideo(
      source: ImageSource.camera,
    ))!
        .path);

    return file;
  } catch (e) {
    log("failed to get image, $e");
    return File("");
  }
}

Future<List<File>> getImageFromAlbum() async {
  final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
    onlyAll: true,
  );
  final List<AssetEntity> entities = await paths[0].getAssetListPaged(
    page: 0,
    size: 80,
  );

  final List<File> files = [];
  for (AssetEntity entity in entities) {
    File? file = await entity.file;
    if (file != null) {
      files.add(file);
    }
  }
  return files;
}

Future<File> getVideoThumbnailFile(File file) async {
  String? type = file.toString().mediaType();
  if (type != "mp4") {
    return file;
  }

  String? fileName = await VideoThumbnail.thumbnailFile(
    video: file.path,
    thumbnailPath: (await getTemporaryDirectory()).path,
    imageFormat: ImageFormat.PNG,
    quality: 80,
  );
  return File(fileName!);
}

Future<MultipartFile> mediaFilesToZip(List<File> files) async {
  Directory directory = await getTemporaryDirectory();

  if (await Directory("${directory.path}/sendImage").exists()) {
    Directory("${directory.path}/sendImage").deleteSync(recursive: true);
  }

  ZipFileEncoder encoder = ZipFileEncoder();
  encoder.create("${directory.path}/sendImage/medias.zip");

  int counter = 1;
  for (File file in files) {
    File copy = await file.copy(
        "${directory.path}/sendImage/$counter.${file.toString().mediaType()}");
    encoder.addFile(copy);
    counter += 1;
  }

  encoder.close();

  File file = File("${directory.path}/sendImage/medias.zip");
  MultipartFile zipFile = MultipartFile.fromFileSync(
    file.path,
    contentType: MediaType("zip", "zip"),
  );

  return zipFile;
}
