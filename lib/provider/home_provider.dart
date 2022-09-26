import 'package:flutter/foundation.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/repository/home_repository.dart';

class HomeProvider extends ChangeNotifier {

  init() async {
    _homeRepository = await HomeRepository.create();
    await getHomeInfo();
  }

  HomeRepository? _homeRepository;
  String? familyCode;
  String? todayFortune;

  Future<bool> getHomeInfo() async {
    Map<String, dynamic> response = await _homeRepository!.getHomeInfo();
    if (response[Strings.message] == Strings.success) {
      familyCode = response[Strings.response][Strings.familyCode];
      todayFortune = response[Strings.response][Strings.todayFortune]?[Strings.content];
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> getTodayFortune() async {
    Map<String, dynamic> response = await _homeRepository!.getTodayFortune();
    if (response[Strings.message] == Strings.success) {
      todayFortune = response[Strings.response][Strings.todayFortune];
      notifyListeners();
      return true;
    }
    return false;
  }
}