import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

getImageFromCamera() async {
  XFile? f = await ImagePicker()
      .pickImage(source: ImageSource.camera); //갤러리에서 사진을 가져옵니다.
  File dummyFile = File(f!.path); //가져온 사진의 Type을 File 형식으로 바꿔줍니다.
  return dummyFile;
}

Future<List<AssetEntity>> getImageFromAlbum() async {
  PhotoManager.setIgnorePermissionCheck(false);
  final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(onlyAll: true);
  final List<AssetEntity> entities = await paths[0].getAssetListPaged(page: 0, size: 80);
  return entities;
}
