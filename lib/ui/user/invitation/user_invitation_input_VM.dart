import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/repository/user_repository.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/utils/notification_controller.dart';
import 'package:provider/provider.dart';

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
        await _userRepository.updateFamilyId(context, familyCode);

    String familyId = response[Strings.familyId];
    await NotificationController(context).subscribe("FAM$familyId");
    await Dio(BaseOptions(
      headers: {
        "Content-Type": "application/json",
        "Authorization": "key=${dotenv.get("FCM_KEY")}"
      },
    )).post(
      "https://fcm.googleapis.com/fcm/send",
      data: {
        "to": "/topics/FAM$familyId",
        "notification": {
          "title": "신규 가족 참가",
          "body": "${context.read<UserProvider>().me!.name}이 가족에 참가했습니다.",
        },
        "data": {
          "title": "신규 가족 참가",
          "body": "${context.read<UserProvider>().me!.name}이 가족에 참가했습니다.",
          'develop': "develop",
          "type": "todo",
          "memberIds": "memberIds",
        }
      },
    );

    if (response[Strings.message] == Strings.success) {
      await Future(() => NotificationController(context).unSubscribeAll());
      Fluttertoast.showToast(msg: "성공적으로 가족을 바꾸었습니다.");
      return true;
    }
    Fluttertoast.showToast(msg: "초대 코드를 확인해주세요");
    return false;
  }
}
