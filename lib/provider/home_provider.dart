import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/dto/fortune.dart';
import 'package:modak_flutter_app/data/dto/today_content.dart';
import 'package:modak_flutter_app/data/repository/home_repository.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/utils/date.dart';
import 'package:provider/provider.dart';

import '../data/datasource/remote_datasource.dart';
import '../utils/file_system_util.dart';

class HomeProvider extends ChangeNotifier {
  Future<void> init() async {
    clear();
    await getHomeInfo();
    await getHomeImage();
    await getTodayTalk(DateTime.now());
    await getTodayFortune();
    notifyListeners();
  }

  final HomeRepository _homeRepository = HomeRepository();
  String? familyCode;
  File? _familyImage;
  Fortune? todayFortune;
  List<TodayContent> todayContents = [];
  int _bottomTabIndex = 0;

  Map<String, Map<int, String>> todayTalkMap = {};
  DateTime _selectedDatetime = DateTime.now();
  DateTime _focusedDateTime = DateTime.now();

  DateTime get selectedDateTime => _selectedDatetime;
  DateTime get focusedDateTime => _focusedDateTime;
  File? get familyImage => _familyImage;
  int get bottomTabIndex => _bottomTabIndex;

  set familyImage(File? familyImage) {
    if (familyImage != null) _familyImage = familyImage;
    notifyListeners();
  }

  set selectedDateTime(DateTime selectedDateTime) {
    _selectedDatetime = selectedDateTime;
    notifyListeners();
  }

  set focusedDateTime(DateTime focusedDateTime) {
    _focusedDateTime = focusedDateTime;
    notifyListeners();
  }

  set bottomTabIndex(int index) {
    _bottomTabIndex = index;
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

  Future<bool> getHomeImage() async {
    Map<String, dynamic> response = await _homeRepository.getHomeImage();
    if (response[Strings.message] == Strings.success) {
      String imageKey = response['response']['imageKey'].toString();

      if (imageKey == "") {
        return true;
      }

      String mediaDirectoryPath = await FileSystemUtil.getMediaDirectory();

      if (mediaDirectoryPath == "") {
        return false;
      }

      if (!File("$mediaDirectoryPath/$imageKey").existsSync()) {
        Map<String, dynamic> urlResponse = await _homeRepository.getMediaURL(
          [
            "media/${(await RemoteDataSource.storage.read(key: Strings.familyId))!}/$imageKey"
          ],
        );

        List<dynamic> urlList = jsonDecode(
          urlResponse['response']['data'],
        )['url_list'];

        String url = urlList[0];

        RegExp regExp = RegExp(r'.com\/(\w|\W)+\?');
        String temp = (regExp.stringMatch(url).toString());
        String fileName = temp.substring(5, temp.length - 1);
        print(fileName);
        final ByteData imageData = await NetworkAssetBundle(
          Uri.parse(url),
        ).load("");
        final Uint8List bytes = imageData.buffer.asUint8List();

        File file = await File(
          '$mediaDirectoryPath/$fileName',
        ).create(recursive: true);
        file.writeAsBytesSync(bytes);

        familyImage = file;
      }

      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> getTodayFortune() async {
    Map<String, dynamic> response = await _homeRepository.getTodayFortune();
    if (response[Strings.message] == Strings.success) {
      todayFortune = response[Strings.response][Strings.todayFortune];
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> getTodayTalk(DateTime dateTime) async {
    if (todayTalkMap[Date.getFormattedDate(dateTime: dateTime)] != null) {
      return false;
    }
    DateTime firstDate = DateTime(dateTime.year, dateTime.month, 1);
    DateTime lastDate = DateTime(dateTime.year, dateTime.month + 1, 0);

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
        notifyListeners();
        return true;
      case Strings.fail:
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

  bool isTodayTalkExist(String date) {
    if (todayTalkMap[date]?.isEmpty ?? true) return false;
    return true;
  }

  clear() {
    familyCode = null;
    todayFortune = null;
    todayContents = [];
    todayTalkMap = {};
    _selectedDatetime = DateTime.now();
    _focusedDateTime = DateTime.now();
  }
}
