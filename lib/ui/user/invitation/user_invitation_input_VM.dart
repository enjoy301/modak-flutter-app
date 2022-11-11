import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/repository/user_repository.dart';
import 'package:modak_flutter_app/utils/notification_controller.dart';

class UserInvitationInputVM extends ChangeNotifier {
  UserInvitationInputVM() {
    init();
  }

  init() async {
    _userRepository = UserRepository();
  }

  late UserRepository _userRepository;

  String _familyCode = "";

  String get familyCode => _familyCode;

  set familyCode(String familyCode) {
    _familyCode = familyCode;
    notifyListeners();
  }

  Future<bool> updateFamilyCode(BuildContext context) async {
    Map<String, dynamic> response =
        await _userRepository.updateFamilyId(familyCode);
    if (response[Strings.message] == Strings.success) {
      await Future(() => NotificationController(context).unSubscribeAll());
      Fluttertoast.showToast(msg: "성공적으로 가족을 바꾸었습니다.");
      return true;
    }
    Fluttertoast.showToast(msg: "초대 코드를 확인해주세요");
    return false;
  }
}
