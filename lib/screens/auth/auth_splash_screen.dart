import 'package:flutter/material.dart';
import 'package:modak_flutter_app/screens/auth/auth_landing_screen.dart';
import 'package:modak_flutter_app/screens/auth/reigster/auth_register_screen.dart';
import 'package:modak_flutter_app/screens/landing_bottomtab_navigator.dart';
import 'package:modak_flutter_app/services/auth_service.dart';
import 'package:modak_flutter_app/utils/prefs_util.dart';

class AuthSplashScreen extends StatefulWidget {
  const AuthSplashScreen({Key? key}) : super(key: key);

  @override
  State<AuthSplashScreen> createState() => _AuthSplashScreenState();
}

class _AuthSplashScreenState extends State<AuthSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("splash screen")),
    );
  }

  @override
  // ignore: must_call_super
  void initState() {
    navigateToNextPage();
  }

  navigateToNextPage() async {
    /// 유저가 생성되어 있을 때 처리
    if (PrefsUtil.getString("refresh_token") != null &&
        PrefsUtil.getString("access_token") != null) {
      /// !TODO accessToken과 refreshToken의 만료에 따른 처리
      Map<String, dynamic> response = await tokenLogin();
      if (response['result'] == 'SUCCESS') {
        Future(() => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const LandingBottomNavigator())));
      } else if (response['result'] == 'FAIL') {
        /// TODO result FAIL 시 처리 방법
      }
    }

    /// 회원가입 진행 중일 때 처리
    else if (PrefsUtil.getBool("is_register_progress") == true) {
      Future(() => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const AuthRegisterScreen())));
    }

    /// 정보가 없을 때 처리
    else {
      Future(() => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const AuthLandingScreen())));
    }
  }
}
