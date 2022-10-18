import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/repository/user_repository.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:provider/provider.dart';

class AuthSplashVM extends ChangeNotifier {
  Future<String> init() async {
    _userRepository = UserRepository();
    if (_userRepository.getIsRegisterProgress() == true) {
      redirectPath = "/auth/register";
    }
    Map<String, dynamic> response = await _userRepository.tokenLogin();
    if (response[Strings.message] == Strings.success) {
      redirectPath = "/main";
    }
    return redirectPath;
  }

  String redirectPath = "/auth/landing";
  redirection(BuildContext context) async {
    Get.offAndToNamed(redirectPath);
  }

  late final UserRepository _userRepository;
}
