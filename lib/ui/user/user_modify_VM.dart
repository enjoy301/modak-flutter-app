import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/dto/user.dart';
import 'package:modak_flutter_app/data/repository/user_repository.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/utils/extension_util.dart';
import 'package:provider/provider.dart';

class UserModifyVM extends ChangeNotifier {
  init() async {
    _userRepository = UserRepository();
    me = _userRepository.getMe()!;
    beforeMe = me!.copyWith();
    isLoaded = true;
  }

  late final UserRepository _userRepository;

  late final BuildContext context;
  bool isLoaded = false;
  User? beforeMe;
  User? me;

  setName(String name) {
    me!.name = name;
    notifyListeners();
  }

  setRole(String role) {
    me!.role = role;
    Get.back();
    notifyListeners();
  }

  setColor(Color color) {
    me!.color = color.colorToString();
    notifyListeners();
  }

  setLunar(bool isLunar) {
    me!.isLunar = isLunar;
    notifyListeners();
  }

  setBirthDay(DateTime birthDay) {
    me!.birthDay = DateFormat("yyyy-MM-dd").format(birthDay);
    notifyListeners();
  }

  onModifyClick(BuildContext context) async {
    if (me == null || beforeMe == null) return;
    Map<String, dynamic> response = await _userRepository.updateMeInfo(beforeMe!, me!);
    if (response['message'] == Strings.success) {
      List<User> newFamilyMembers = response[Strings.response][Strings.familyMembers];
      Fluttertoast.showToast(msg: "정보 수정 완료");
      await Future(() => context.read<UserProvider>().me = me);
      await Future(() => context.read<UserProvider>().familyMembers = newFamilyMembers);
      Get.back();
    } else {
      Fluttertoast.showToast(msg: "정보 수정 실패");
    }
  }
}
