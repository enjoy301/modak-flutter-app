import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/datasource/local_datasource.dart';
import 'package:modak_flutter_app/data/datasource/remote_datasource.dart';

/// response: returns response which should be updated
/// message: acknowledges result of request

class HomeRepository {
  HomeRepository._create();

  static Future<HomeRepository> create() async {
    HomeRepository albumRepository = HomeRepository._create();
    localDataSource ??= await LocalDataSource.create();
    remoteDataSource ??= RemoteDataSource();
    return albumRepository;
  }

  static LocalDataSource? localDataSource;
  static RemoteDataSource? remoteDataSource;

  Future<Map<String, dynamic>> getHomeInfo() async {
    Map<String, dynamic> response = await remoteDataSource!.getHomeInfo();
    if (response[Strings.result]) {
      Map<String, dynamic> data = response[Strings.response].data["data"];
      print(data);
      return {
        Strings.message: Strings.success,
        Strings.response: {
          Strings.todayFortune: data[Strings.todayFortune],
          Strings.familyCode: data[Strings.memberAndFamilyMembers]
              [Strings.familyCode],
        }
      };
    }
    return {Strings.message: Strings.fail};
  }

  Future<Map<String, dynamic>> getTodayFortune() async {
    Map<String, dynamic> response = await remoteDataSource!.getTodayFortune();
    if (response[Strings.result]) {
      Map<String, dynamic> data = response[Strings.response].data["data"];
      return {
        Strings.message: Strings.success,
        Strings.response: {
          Strings.todayFortune: data[Strings.content],
        }
      };
    }
    return {Strings.message: Strings.fail};
  }

  Future<Map<String, dynamic>> getTodayTalk(
      String fromDate, String toDate) async {
    Map<String, dynamic> response =
        await remoteDataSource!.getTodayTalk(fromDate, toDate);
    if (response[Strings.result]) {
      Map<String, dynamic> data =
          response[Strings.response].data["data"][Strings.result];
      Map<String, Map<int, String>> result = {};
      for (String key in data.keys) {
        result[key] = <int, String>{};
        for (String rawUserId in data[key].keys) {
          int userId = int.parse(rawUserId);
          result[key]![userId] = data[key]![rawUserId];
        }
      }
      return {
        Strings.message: Strings.success,
        Strings.response: {
          Strings.todayTalk: result,
        },
      };
    }
    return {
      Strings.message: Strings.fail,
    };
  }

  Future<Map<String, dynamic>> postTodayTalk(String content) async {
    Map<String, dynamic> response =
        await remoteDataSource!.postTodayTalk(content);
    if (response[Strings.result]) {
      return {Strings.message: Strings.success};
    }
    return {
      Strings.message: Strings.fail,
    };
  }
}
