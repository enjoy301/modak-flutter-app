import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

Future<XFile?> getImageFromCamera() async {
  try {
    XFile? f = await ImagePicker()
        .pickImage(source: ImageSource.camera); //갤러리에서 사진을 가져옵니다.
    return Future(() => f);
  } catch(e) {
    print("failed to get image");
  }
}

Future<XFile?> getVideoFromCamera() async {
  try {
    XFile? f = await ImagePicker()
        .pickVideo(source: ImageSource.camera); //갤러리에서 사진을 가져옵니다.
    return Future(() => f);
  } catch(e) {
    print("failed to get video");
  }
}

Future<List<AssetEntity>> getImageFromAlbum() async {
  PhotoManager.setIgnorePermissionCheck(false);
  final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(onlyAll: true);
  final List<AssetEntity> entities = await paths[0].getAssetListPaged(page: 0, size: 80);
  return entities;
}
