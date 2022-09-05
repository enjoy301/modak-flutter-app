import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/datasource/local_datasource.dart';
import 'package:modak_flutter_app/data/datasource/remote_datasource.dart';

class TodoRepository {
  TodoRepository._create();

  static Future<TodoRepository> create() async {
    TodoRepository albumRepository = TodoRepository._create();
    localDataSource ??= await LocalDataSource.create();
    remoteDataSource ??= RemoteDataSource();
    return albumRepository;
  }

  static LocalDataSource? localDataSource;
  static RemoteDataSource? remoteDataSource;

  Future<String> getTodos() async {
    Map<String, dynamic> response =
        await remoteDataSource!.getTodos("2022-09-01", "2022-09-12");
    print(response);
    if (response[Strings.result]) {
      return Strings.success;
    }
    return Strings.fail;
  }
}
