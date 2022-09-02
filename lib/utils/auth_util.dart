import 'dart:io';

import 'package:get/route_manager.dart';

import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
import 'package:modak_flutter_app/provider/auth_provider.dart';
import 'package:modak_flutter_app/ui/auth/auth_landing_screen.dart';
import 'package:modak_flutter_app/ui/auth/register/auth_register_screen.dart';
import 'package:modak_flutter_app/ui/landing_bottomtab_navigator.dart';
import 'package:modak_flutter_app/services/auth_service.dart';
import 'package:modak_flutter_app/services/user_service.dart';
import 'package:modak_flutter_app/utils/file_system_util.dart';
import 'package:modak_flutter_app/utils/prefs_util.dart';
import 'package:provider/provider.dart';

class AuthUtil {
  static Future<bool> kakaoLogin(BuildContext context) async {
    try {
      late OAuthToken token;
      if (await isKakaoTalkInstalled()) {
        token = await UserApi.instance.loginWithKakaoTalk();
      } else {
        token = await UserApi.instance.loginWithKakaoAccount();
      }
      User user = await UserApi.instance.me();
      context.read<AuthProvider>().setProvider("KAKAO");
      context.read<AuthProvider>().setProviderId(user.id);
    } catch (e) {
      return false;
    }
    return true;
  }

  static void authRedirection(BuildContext context,
      {bool isLoad = false}) async {
    if (PrefsUtil.getString("refresh_token") != null &&
        PrefsUtil.getString("access_token") != null &&
        PrefsUtil.getInt("user_id") != null) {
      Map<String, dynamic> response = await tokenLogin();
      if (response['result'] == 'SUCCESS') {
        if (isLoad) {
          await Future(
              () async => await FileSystemUtil.loadMediaOnMemory(context));
        }
        if (PrefsUtil.getString("user_name") == null) {
          // ignore: use_build_context_synchronously
          Map<String, dynamic> response = await reloadUserInfo(context);
          if (response['result'] == 'FAIL') {
            Get.offAll(() => AuthLandingScreen());
          }
        }
        Get.offAll(() => LandingBottomNavigator());
      } else if (response['result'] == 'FAIL') {
        if (response['code'] == "MalformedJwtException" ||
            response['code'] == "SignatureException" ||
            response['code'] == "ExpiredJwtException") {
          Get.offAll(() => AuthLandingScreen());
        } else {
          Get.offAll(() => AuthLandingScreen());
        }
      }
    }

    /// 회원가입 진행 중일 때 처리
    else if (PrefsUtil.getBool("is_register_progress") == true) {
      Get.offAll(() => AuthRegisterScreen());
    }

    /// 정보가 없을 때 처리
    else {
      Get.offAll(() => AuthLandingScreen());
    }
  }
}
