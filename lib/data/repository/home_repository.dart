import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/datasource/local_datasource.dart';
import 'package:modak_flutter_app/data/datasource/remote_datasource.dart';
import 'package:modak_flutter_app/data/dto/fortune.dart';

/// response: returns response which should be updated
/// message: acknowledges result of request

class HomeRepository {
  HomeRepository._privateConstructor() {
    localDataSource = LocalDataSource();
    remoteDataSource = RemoteDataSource();
  }

  factory HomeRepository() {
    return _instance;
  }

  static final HomeRepository _instance = HomeRepository._privateConstructor();
  static late final LocalDataSource localDataSource;
  static late final RemoteDataSource remoteDataSource;

  Future<Map<String, dynamic>> getHomeInfo() async {
    Map<String, dynamic> response = await remoteDataSource.getHomeInfo();

    if (response[Strings.result]) {
      Map<String, dynamic> data = response[Strings.response].data["data"];
      Map<String, dynamic>? todayFortuneData = data[Strings.todayFortune];
      return {
        Strings.message: Strings.success,
        Strings.response: {
          Strings.todayFortune: todayFortuneData == null
              ? null
              : Fortune(
                  type: todayFortuneData['type'],
                  content: todayFortuneData[Strings.content]),
          Strings.familyCode: data[Strings.memberAndFamilyMembers]
              [Strings.familyCode],
          Strings.todayContents: data[Strings.todayContents],
        }
      };
    }
    return {Strings.message: Strings.fail};
  }

  Future<Map<String, dynamic>> getTodayFortune() async {
    Map<String, dynamic> response = await remoteDataSource.getTodayFortune();
    if (response[Strings.result]) {
      Map<String, dynamic>? data = response[Strings.response].data["data"];
      return {
        Strings.message: Strings.success,
        Strings.response: {
          Strings.todayFortune: data == null
              ? null
              : Fortune(type: data['type'], content: data[Strings.content])
        }
      };
    }
    return {Strings.message: Strings.fail};
  }

  Future<Map<String, dynamic>> getTodayTalk(
    String fromDate,
    String toDate,
  ) async {
    Map<String, dynamic> response =
        await remoteDataSource.getTodayTalk(fromDate, toDate);
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
        await remoteDataSource.postTodayTalk(content);
    if (response[Strings.result]) {
      return {Strings.message: Strings.success};
    }
    return {
      Strings.message: Strings.fail,
    };
  }

  getNoti() {}
}
