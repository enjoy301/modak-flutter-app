import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/model/user.dart';
import 'package:modak_flutter_app/data/repository/user_repository.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/utils/extension_util.dart';
import 'package:provider/provider.dart';

class UserModifyVM extends ChangeNotifier {
  init() async {
    _userRepository = await UserRepository.create();
    user = _userRepository.getMe()!;
    isLoaded = true;
  }

  late final UserRepository _userRepository;

  late final BuildContext context;
  bool isLoaded = false;
  User? user;

  setName(String name) {
    user!.name = name;
    notifyListeners();
  }

  setRole(String role) {
    user!.role = role;
    Get.back();
    notifyListeners();
  }

  setColor(Color color) {
    user!.color = color.colorToString();
    notifyListeners();
  }

  setLunar(bool isLunar) {
    user!.isLunar = isLunar;
    notifyListeners();
  }

  setBirthDay(DateTime birthDay) {
    user!.birthDay = DateFormat("yyyy-MM-dd").format(birthDay);
    notifyListeners();
  }

  onModifyClick(BuildContext context) async {
    if (user == null) return;
    Map<String, dynamic> response = await _userRepository.updateMeInfo(user!);

    if (response['message'] == Strings.success) {
      Fluttertoast.showToast(msg: "정보 수정 완료");
      await Future(() => context.read<UserProvider>().me = user);
      Get.back();
    } else {
      Fluttertoast.showToast(msg: "정보 수정 실패");
    }
  }
}