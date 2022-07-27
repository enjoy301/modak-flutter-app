import 'package:flutter/material.dart';
import 'package:modak_flutter_app/screens/auth/reigster/auth_register_screen.dart';
import 'package:modak_flutter_app/services/auth_service.dart';
import 'package:modak_flutter_app/utils/auth_util.dart';
import 'package:modak_flutter_app/utils/prefs_util.dart';

class AuthLandingScreen extends StatefulWidget {
  const AuthLandingScreen({Key? key}) : super(key: key);

  @override
  State<AuthLandingScreen> createState() => _AuthLandingScreenState();
}

class _AuthLandingScreenState extends State<AuthLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextButton(
              onPressed: () async {
                await AuthUtil.kakaoLogin(context);
                if (PrefsUtil.getInt("provider_id") != null && PrefsUtil.getString("provider") != null) {
                  PrefsUtil.setBool("is_register_progress", true);
                  Future(() => Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthRegisterScreen())));
                }
              },
              child: Text("카카오로 로그인"),
            ),
            TextButton(
              onPressed: () async {
                tokenLogin();
              },
              child: Text("통신 테스트"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
  }
}
