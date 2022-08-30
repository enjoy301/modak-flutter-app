import 'package:flutter/material.dart';
import 'package:modak_flutter_app/ui/auth/auth_instruction_screen.dart';
import 'package:modak_flutter_app/ui/auth/reigster/auth_register_screen.dart';
import 'package:modak_flutter_app/ui/landing_bottomtab_navigator.dart';
import 'package:modak_flutter_app/services/auth_service.dart';
import 'package:modak_flutter_app/utils/auth_util.dart';
import 'package:modak_flutter_app/utils/prefs_util.dart';
import 'package:modak_flutter_app/widgets/auth/auth_introduction_widget.dart';
import 'package:modak_flutter_app/widgets/button/button_main_widget.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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
        backgroundColor: Colors.white,
        appBar: headerDefaultWidget(title: "Modak"),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: EdgeInsets.only(top: 40),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    AuthIntroductionWidget(
                      name: "washer",
                    ),
                    AuthIntroductionWidget(
                      name: "album",
                    ),
                    AuthIntroductionWidget(
                      name: "chat",
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: ButtonMainWidget(
                title: "가족 방에 초대 받았습니다",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AuthInstructionScreen()));
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 54,
              ),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () async {
                        await AuthUtil.kakaoLogin(context);
                        if (PrefsUtil.getInt("provider_id") != null &&
                            PrefsUtil.getString("provider") != null) {
                          // ignore: use_build_context_synchronously
                          Map<String, dynamic> response = await socialLogin(context);
                          print(response['result']);
                          if (response['result'] == "FAIL") {
                            if (response['code'] ==
                                "EmptyResultDataAccessException") {
                              PrefsUtil.setBool("is_register_progress", true);
                              Future(() => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AuthRegisterScreen())));
                            }
                          } else {
                            Future(() => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LandingBottomNavigator())));
                          }
                        }
                      },
                      child: Image.asset(
                        "lib/assets/images/auth/kakao_login.png",
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        final appIdCredential =
                            await SignInWithApple.getAppleIDCredential(scopes: [
                          AppleIDAuthorizationScopes.fullName,
                          AppleIDAuthorizationScopes.email
                        ]);
                        debugPrint(appIdCredential.userIdentifier);
                      },
                      child: Image.asset(
                        "lib/assets/images/auth/apple_login.png",
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
