import 'dart:convert';

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
      return {Strings.message: Strings.success, Strings.response: {
        Strings.todayFortune: data[Strings.todayFortune],
        Strings.familyCode: data[Strings.memberAndFamilyMembers][Strings.familyCode],
      }};
    }
    return {Strings.message: Strings.fail};
  }

  Future<Map<String, dynamic>> getTodayFortune() async {
    Map<String, dynamic> response = await remoteDataSource!.getTodayFortune();
    if (response[Strings.result]) {
      Map<String, dynamic> data = response[Strings.response].data["data"];
      return {Strings.message: Strings.success, Strings.response: {
        Strings.todayFortune: data[Strings.content],
      }};
    }
    return {Strings.message: Strings.fail};
  }
}
