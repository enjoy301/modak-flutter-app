import 'package:modak_flutter_app/data/datasource/local_datasource.dart';
import 'package:modak_flutter_app/data/datasource/remote_datasource.dart';

class AlbumRepository {
  final LocalDataSource _localDataSource = LocalDataSource();
  final RemoteDataSource _remoteDataSource = RemoteDataSource();
}