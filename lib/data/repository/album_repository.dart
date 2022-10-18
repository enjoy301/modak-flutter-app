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

  static final AlbumRepository _instance =
      AlbumRepository._privateConstructor();
  static late final LocalDataSource localDataSource;
  static late final RemoteDataSource remoteDataSource;

  Future<Map<String, dynamic>> getMediaInfoList(int lastId, int count) async {
    Map<String, dynamic> response =
        await remoteDataSource.getMediaInfoList(lastId, count);

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
    Map<String, dynamic> response =
        await remoteDataSource.getMediaDownloadURL(requestList);

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
