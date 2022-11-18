import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/datasource/local_datasource.dart';
import 'package:modak_flutter_app/data/datasource/remote_datasource.dart';

class AlbumRepository {
  AlbumRepository._privateConstructor() {
    localDataSource = LocalDataSource();
    remoteDataSource = RemoteDataSource();
  }

  factory AlbumRepository() {
    return _instance;
  }

  static final AlbumRepository _instance = AlbumRepository._privateConstructor();
  static late final LocalDataSource localDataSource;
  static late final RemoteDataSource remoteDataSource;

  Future<Map<String, dynamic>> getMediaInfoList(int lastId, int count) async {
    Map<String, dynamic> response = await remoteDataSource.getMediaInfoList(lastId, count);

    if (response[Strings.result]) {
      return {
        Strings.message: Strings.success,
        Strings.response: {
          "data": response["response"].data,
        }
      };
    }
    return {Strings.message: Strings.fail};
  }

  Future<Map<String, dynamic>> getFaceList() async {
    Map<String, dynamic> response = await remoteDataSource.getFaceList();

    if (response[Strings.result]) {
      return {
        Strings.message: Strings.success,
        Strings.response: {
          "data": response["response"].data,
        }
      };
    }
    return {Strings.message: Strings.fail};
  }

  Future<Map<String, dynamic>> getLabelList() async {
    Map<String, dynamic> response = await remoteDataSource.getLabelList();

    if (response[Strings.result]) {
      return {
        Strings.message: Strings.success,
        Strings.response: {
          "data": response["response"].data,
        }
      };
    }
    return {Strings.message: Strings.fail};
  }

  Future<Map<String, dynamic>> getFaceDetail(int lastId, int count, int clusterId) async {
    Map<String, dynamic> response = await remoteDataSource.getFaceDetail(lastId, count, clusterId);

    if (response[Strings.result]) {
      return {
        Strings.message: Strings.success,
        Strings.response: {
          "data": response["response"].data,
        }
      };
    }
    return {Strings.message: Strings.fail};
  }

  Future<Map<String, dynamic>> getLabelDetail(int lastId, int count, String labelName) async {
    Map<String, dynamic> response = await remoteDataSource.getLabelDetail(lastId, count, labelName);

    if (response[Strings.result]) {
      return {
        Strings.message: Strings.success,
        Strings.response: {
          "data": response["response"].data,
        }
      };
    }
    return {Strings.message: Strings.fail};
  }

  Future<Map<String, dynamic>> setFamilyImage(String key) async {
    Map<String, dynamic> response = await remoteDataSource.setFamilyImage(key);

    if (response[Strings.result]) {
      return {
        Strings.message: Strings.success,
        Strings.response: {
          "data": response["response"].data,
        }
      };
    }
    return {Strings.message: Strings.fail};
  }

  Future<Map<String, dynamic>> getMediaURL(List<dynamic> requestList) async {
    Map<String, dynamic> response = await remoteDataSource.getMediaDownloadURL(requestList);

    if (response[Strings.result]) {
      return {
        Strings.message: Strings.success,
        Strings.response: {
          "data": response["response"].data,
        }
      };
    }
    return {Strings.message: Strings.fail};
  }
}
