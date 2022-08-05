import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
import 'package:modak_flutter_app/provider/auth_provider.dart';
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
      context.read<AuthProvider>().setProviderId(user.id-1);
    } catch(e) {
      return false;
    }
    return true;
  }
}