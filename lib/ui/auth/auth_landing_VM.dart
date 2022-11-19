import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/repository/user_repository.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/utils/provider_controller.dart';
import 'package:provider/provider.dart';

class AuthLandingVM extends ChangeNotifier {
  AuthLandingVM() {
    _init();
  }

  _init() async {}

  final UserRepository? userRepository = UserRepository();

  void onSocialClick(BuildContext context, String type) async {
    Map<String, dynamic> response = await userRepository!.socialLogin(type);
    switch (response[Strings.message]) {
      case Strings.success:
        await Future(
            () => context.read<UserProvider>().familyMembers = response[Strings.response][Strings.familyMembers]);
        await Future(() => context.read<UserProvider>().me = response[Strings.response][Strings.me]);
        await Future(() async => await ProviderController.startProviders(context));
        log(response[Strings.response]);
        Fluttertoast.showToast(msg: "로그인에 성공하셨습니다");
        Get.offAllNamed("/auth/splash");
        break;
      case Strings.fail:
        Fluttertoast.showToast(msg: "로그인에 실패하셨습니다");
        break;
      case Strings.noUser:
        Fluttertoast.showToast(msg: "회원가입 페이지로 이동합니다");
        Get.offAllNamed("/auth/register");
        break;
    }
  }
}
