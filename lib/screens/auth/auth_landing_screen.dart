import 'package:flutter/material.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/screens/auth/reigster/auth_register_screen.dart';
import 'package:modak_flutter_app/utils/auth_util.dart';
import 'package:modak_flutter_app/utils/prefs_util.dart';
import 'package:modak_flutter_app/widgets/auth/auth_introduction_widget.dart';
import 'package:modak_flutter_app/widgets/button/button_main_widget.dart';

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
        appBar: AppBar(
          leading: Ink(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0XFFF7F8F8),
            ),
            child: IconButton(
              onPressed: () {
                print("안녕");
              },
              icon: Icon(
                LightIcons.ArrowLeft2,
                size: 16,
                color: Coloring.gray_0,
              ),
            ),
          ),
          centerTitle: true,
          title: Text("Modak",
              style: TextStyle(
                color: Colors.black,
                fontSize: Font.size_largeText,
                fontWeight: Font.weight_bold,
              )),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
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
                onPressed: () {},
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
                          PrefsUtil.setBool("is_register_progress", true);
                          Future(() => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AuthRegisterScreen())));
                        }
                      },
                      child: Image.asset(
                        "lib/assets/kakao_login.png",
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        await AuthUtil.kakaoLogin(context);
                        if (PrefsUtil.getInt("provider_id") != null &&
                            PrefsUtil.getString("provider") != null) {
                          PrefsUtil.setBool("is_register_progress", true);
                          Future(() => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AuthRegisterScreen())));
                        }
                      },
                      child: Image.asset(
                        "lib/assets/apple_login.png",
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {}
}
