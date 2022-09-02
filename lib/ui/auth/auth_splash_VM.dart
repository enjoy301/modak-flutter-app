import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/repository/user_repository.dart';

class AuthSplashVM extends ChangeNotifier {

  AuthSplashVM() {
    _init();
  }

  _init() async {
    _userRepository = await UserRepository.create();
    await _redirection();
  }

  _redirection() async {
    if (_userRepository.getIsRegisterProgress() == true) {
      Get.offAllNamed("/auth/register");
      return;
    }
    String response = await _userRepository.tokenLogin();
    if (response == Strings.success) {
      Get.offAllNamed("/main");
    } else {
      Get.offAllNamed("/auth/landing");
    }
  }

  late final UserRepository _userRepository;
}