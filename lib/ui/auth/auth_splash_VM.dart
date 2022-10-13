import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/repository/user_repository.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:provider/provider.dart';

class AuthSplashVM extends ChangeNotifier {
  init() async {
    _userRepository = UserRepository();
  }

  redirection(BuildContext context) async {
    if (_userRepository.getIsRegisterProgress() == true) {
      Get.offAllNamed("/auth/register");
      return;
    }
    Map<String, dynamic> response = await _userRepository.tokenLogin();
    if (response[Strings.message] == Strings.success) {
      await Future(
          () => context.read<UserProvider>().me = _userRepository.getMe());
      Get.offAllNamed("/main");
    } else {
      Get.offAllNamed("/auth/landing");
    }
  }

  late final UserRepository _userRepository;
}
