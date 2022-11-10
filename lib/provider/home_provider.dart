import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/dto/fortune.dart';
import 'package:modak_flutter_app/data/dto/today_content.dart';
import 'package:modak_flutter_app/data/repository/home_repository.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/utils/date.dart';
import 'package:provider/provider.dart';

class HomeProvider extends ChangeNotifier {
  init() async {
    clear();
    await getHomeInfo();
    await getTodayTalk(DateTime.now());
    await getTodayFortune();
    notifyListeners();
  }

  final HomeRepository _homeRepository = HomeRepository();
  String? familyCode;
  Fortune? todayFortune;
  List<TodayContent> todayContents = [];

  Map<String, Map<int, String>> todayTalkMap = {};
  DateTime _selectedDatetime = DateTime.now();
  DateTime _focusedDateTime = DateTime.now();

  DateTime get selectedDateTime => _selectedDatetime;
  DateTime get focusedDateTime => _focusedDateTime;

  set selectedDateTime(DateTime selectedDateTime) {
    _selectedDatetime = selectedDateTime;
    notifyListeners();
  }

  set focusedDateTime(DateTime focusedDateTime) {
    _focusedDateTime = focusedDateTime;
    notifyListeners();
  }

  Future<bool> getHomeInfo() async {
    Map<String, dynamic> response = await _homeRepository.getHomeInfo();
    if (response[Strings.message] == Strings.success) {
      familyCode = response[Strings.response][Strings.familyCode];
      todayFortune = response[Strings.response][Strings.todayFortune];
      List<TodayContent> replacer = [];
      for (Map item in response[Strings.response][Strings.todayContents]) {
        replacer.add(
          TodayContent(
            id: item['id'],
            type: item['type'],
            title: item['title'],
            desc: item['description'],
            url: item['url'],
          ),
        );
      }
      todayContents = replacer;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> getTodayFortune() async {
    Map<String, dynamic> response = await _homeRepository.getTodayFortune();
    if (response[Strings.message] == Strings.success) {
      todayFortune = response[Strings.response][Strings.todayFortune];
      print(response[Strings.response]);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> getTodayTalk(DateTime dateTime) async {
    if (todayTalkMap[Date.getFormattedDate(dateTime: dateTime)] != null) {
      return false;
    }
    DateTime firstDate = Date.getFirstDayOfWeek(dateTime);
    DateTime lastDate = firstDate.add(Duration(days: 6));

    String firstDateString = Date.getFormattedDate(dateTime: firstDate);
    String lastDateString = Date.getFormattedDate(dateTime: lastDate);

    Map<String, dynamic> response =
        await _homeRepository.getTodayTalk(firstDateString, lastDateString);
    switch (response[Strings.message]) {
      case Strings.success:
        Map<String, Map<int, String>> todayTalkWeekMap =
            response[Strings.response][Strings.todayTalk];
        for (String date in todayTalkWeekMap.keys) {
          todayTalkMap[date] = todayTalkWeekMap[date]!;
        }
        Fluttertoast.showToast(msg: "오늘의 한마디 가져오기 성공");
        notifyListeners();
        return true;
      case Strings.fail:
        Fluttertoast.showToast(msg: "오늘의 한마디 가져오기 실패");
        notifyListeners();
        return false;
    }
    return false;
  }

  Future<bool> postTodayTalk(BuildContext context, String content) async {
    String date = Date.getFormattedDate();
    Map<String, dynamic> response =
        await _homeRepository.postTodayTalk(content);
    switch (response[Strings.message]) {
      case Strings.success:
        if (todayTalkMap[date] == null) todayTalkMap[date] = <int, String>{};
        todayTalkMap[date]![context.read<UserProvider>().me!.memberId] =
            content;
        Fluttertoast.showToast(msg: "오늘의 한 마디를 등록하였습니다");
        notifyListeners();
        return true;
      case Strings.fail:
        Fluttertoast.showToast(msg: "등록 실패");
        return false;
    }
    return false;
  }

  clear() {
    familyCode = null;
    todayFortune = null;
    todayTalkMap = {};
    _selectedDatetime = DateTime.now();
    _focusedDateTime = DateTime.now();
  }
}
