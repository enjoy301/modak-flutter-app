import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/repository/user_repository.dart';
import 'package:modak_flutter_app/ui/auth/register/auth_register_screen.dart';
import 'package:modak_flutter_app/ui/landing_bottomtab_navigator.dart';

class AuthLandingVM extends ChangeNotifier {
  AuthLandingVM() {
    _init();
  }
  _init() async {
    userRepository = await UserRepository.create();
  }
  late final UserRepository? userRepository;
   void onKakaoClick() async {
    if (userRepository != null) {
      String response = await userRepository!.kakaoSocialLogin();
      switch (response) {
        case Strings.success:
          Fluttertoast.showToast(msg: "로그인에 성공하셨습니다");
          Get.offAllNamed("/main");
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
}