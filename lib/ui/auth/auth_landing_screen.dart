import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/ui/auth/auth_landing_VM.dart';
import 'package:modak_flutter_app/widgets/auth/auth_introduction_widget.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:provider/provider.dart';

class AuthLandingScreen extends StatefulWidget {
  const AuthLandingScreen({Key? key}) : super(key: key);

  @override
  State<AuthLandingScreen> createState() => _AuthLandingScreenState();
}

class _AuthLandingScreenState extends State<AuthLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthLandingVM>(builder: (context, provider, _) {
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
              GestureDetector(
                onTap: () => provider.onSocialClick(context, "KAKAO"),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(right: 30, bottom: 20, left: 30),
                  decoration: BoxDecoration(
                    color: Color(0XFFffeb3b),
                    borderRadius: BorderRadius.circular(48),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "lib/assets/images/auth/kakao_login.png",
                        width: 60,
                        height: 60,
                      ),
                      Text("카카오 계정으로 로그인", style: TextStyle(
                        color: Colors.black,
                        fontSize: Font.size_largeText,
                        fontWeight: Font.weight_semiBold,
                      ),)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => provider.onSocialClick(context, "APPLE"),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  margin: EdgeInsets.only(right: 30, bottom: 50, left: 30),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(48),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Image.asset(
                          "lib/assets/images/auth/apple_icon.png",
                          width: 30,
                          height: 30,
                        ),
                      ),
                      Text("애플 계정으로 로그인", style: TextStyle(
                        color: Colors.white,
                        fontSize: Font.size_largeText,
                        fontWeight: Font.weight_semiBold,
                      ),)
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      );
    });
  }
}
