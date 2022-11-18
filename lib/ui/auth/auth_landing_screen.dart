import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
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
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(gradient: Coloring.notice),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              headerDefaultWidget(
                title: "Modak",
                bgColor: Colors.transparent,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: CarouselSlider(
                      items: [
                        AuthIntroductionWidget(
                          name: "album",
                        ),
                        AuthIntroductionWidget(
                          name: "washer",
                        ),
                        AuthIntroductionWidget(
                          name: "chat",
                        ),
                      ],
                      options: CarouselOptions(
                          height: double.infinity,
                          enlargeStrategy: CenterPageEnlargeStrategy.scale)),
                ),
              ),
              GestureDetector(
                onTap: () => provider.onSocialClick(context, "KAKAO"),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  margin: EdgeInsets.only(right: 30, bottom: 20, left: 30),
                  decoration: BoxDecoration(
                    color: Color(0XFFffeb3b),
                    borderRadius: BorderRadius.circular(48),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 18),
                        child: Image.asset(
                          "lib/assets/images/auth/kakao_icon.png",
                          width: 30,
                          height: 30,
                        ),
                      ),
                      Text(
                        "Kakao 로그인",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Font.size_largeText,
                          fontWeight: Font.weight_semiBold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if (Platform.isIOS)
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
                          padding: const EdgeInsets.only(right: 15),
                          child: Image.asset(
                            "lib/assets/images/auth/apple_icon.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                        Text(
                          "Apple 로그인",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Font.size_largeText,
                            fontWeight: Font.weight_semiBold,
                          ),
                        ),
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
