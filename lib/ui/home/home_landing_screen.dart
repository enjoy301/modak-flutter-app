import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/home_provider.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/widgets/home/home_family_fortune_widget.dart';
import 'package:modak_flutter_app/widgets/home/home_family_info_widget.dart';
import 'package:modak_flutter_app/widgets/home/home_family_talk_widget.dart';
import 'package:modak_flutter_app/widgets/home/home_letter_widget.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';

class HomeLandingScreen extends StatefulWidget {
  const HomeLandingScreen({Key? key}) : super(key: key);

  @override
  State<HomeLandingScreen> createState() => _HomeLandingScreenState();
}

class _HomeLandingScreenState extends State<HomeLandingScreen> {
  List<String> headerTitle = ["오늘 우리 가족은", "오늘의 컨텐츠"];

  @override
  Widget build(BuildContext context) {
    ScrollController? controller;
    return Consumer2<UserProvider, HomeProvider>(
        builder: (context, userProvider, homeProvider, child) {
      return Scaffold(
        body: SafeArea(
          child: ListView.builder(
            itemCount: 2,
            primary: controller == null,
            controller: controller,
            itemBuilder: (context, index) {
              return StickyHeaderBuilder(
                controller: controller, // Optional
                builder: (BuildContext context, double stuckAmount) {
                  stuckAmount = 1.0 - stuckAmount.clamp(0.0, 1.0);
                  return GestureDetector(
                    onTap: () {
                      homeProvider.getHomeInfo();
                    },
                    child: Container(
                      height: 60.0,
                      color: Color.lerp(
                          Coloring.gray_50, Colors.white, stuckAmount),
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              headerTitle[index],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: Font.size_h1,
                                  fontWeight: Font.weight_semiBold),
                            ),
                          ),
                          Offstage(
                            offstage: stuckAmount <= 0.0,
                            child: Opacity(
                              opacity: stuckAmount,
                              child: IconButton(
                                icon: const Icon(Icons.notifications_none,
                                    color: Colors.black),
                                onPressed: () {
                                  Get.toNamed("/home/notification");
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                content: Container(
                    color: Coloring.gray_50,
                    child: Column(children: [
                      if (index == 0)
                        HomeFamilyTalkWidget(name: "name", content: "content"),
                      if (index == 1) HomeFamilyFortuneWidget(),
                      if (index == 1) HomeLetterWidget(),
                      if (index == 1)
                        HomeFamilyInfoWidget(
                          type: HomePostType.cook,
                          title: "백종원의 요리쇼",
                          contents: "슈가 보이 백종원의 궁중 떡볶이 만드는 법!",
                          link: "https://www.naver.com",
                        ),
                      if (index == 1)
                        HomeFamilyInfoWidget(
                          type: HomePostType.travel,
                          title: "캠핑장 추천",
                          contents: "몽산포에 있는 기가막힌 캠핑장",
                          link: "https://www.naver.com",
                        ),
                      if (index == 1)
                        SizedBox(
                          height: 100,
                        )
                    ])),
              );
            },
          ),
        ),
      );
    });
  }
}
