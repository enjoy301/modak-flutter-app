import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/home_provider.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/ui/home/talk/home_talk_view_screen.dart';
import 'package:modak_flutter_app/ui/home/talk/home_talk_write_screen.dart';
import 'package:modak_flutter_app/utils/time.dart';
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
      return SafeArea(
        child: ListView.builder(
          itemCount: 2,
          primary: controller == null,
          controller: controller,
          itemBuilder: (context, index) {
            return StickyHeaderBuilder(
              controller: controller, // Optional
              builder: (BuildContext context, double stuckAmount) {
                stuckAmount = 1.0 - stuckAmount.clamp(0.0, 1.0);
                return Container(
                  height: 60.0,
                  color: Color.lerp(Colors.white, Coloring.bg_red, stuckAmount),
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
                );
              },
              content: Container(
                  color: Colors.white,
                  child: Column(children: [
                    if (index == 0)
                      homeProvider.todayTalkMap[getFormattedDate()]
                                  ?[userProvider.me!.memberId] ==
                              null
                          ? GestureDetector(
                              onTap: () {
                                Get.to(HomeTalkWriteScreen());
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 30, right: 20, left: 20),
                                child: Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[100],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "오늘의 한 마디를 입력하고,\n 다른 가족들의 한 마디를 확인하세요!",
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                              ))
                          : Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: CarouselSlider(
                                options:
                                    CarouselOptions(enlargeCenterPage: true),
                                items: homeProvider
                                    .todayTalkMap[getFormattedDate()]?.keys
                                    .map((int member) {
                                  return GestureDetector(
                                      onTap: () {
                                        Get.to(HomeTalkViewScreen());
                                      },
                                      child: FamilyTalkWidget(
                                        name: userProvider.findUserById(member)?.name ?? "익명",
                                          content: homeProvider.todayTalkMap[
                                              getFormattedDate()]![member]!));
                                }).toList(),
                              ),
                            ),
                    if (index == 1) FamilyFortuneWidget(),
                    if (index == 1) FamilyFortuneWidget(),
                  ])),
            );
          },
        ),
      );
    });
  }
}

class FamilyFortuneWidget extends StatelessWidget {
  const FamilyFortuneWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
      return GestureDetector(
        onTap: () {
          Get.toNamed("/chat/letter/landing");
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 18, left: 18),
          child: Container(
            decoration: BoxDecoration(
              color: Coloring.point_pureorange,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 20),
                  child: Text(
                    "하루 한 문장",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Font.size_largeText,
                      fontWeight: Font.weight_semiBold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, right: 20, left: 25),
                        child: Text(
                          homeProvider.todayFortune == null
                              ? "클릭해서 오늘의 운세를 확인하세요!"
                              : "${homeProvider.todayFortune!}\n\n\n",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Font.size_h3,
                            fontWeight: Font.weight_medium,
                          ),
                          maxLines: 4,
                        ),
                      ),
                    ),
                    Image.asset(
                      "lib/assets/images/others/Man1.png",
                      width: 90,
                      height: 190,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class FamilyTalkWidget extends StatelessWidget {
  const FamilyTalkWidget({Key? key, required this.name, required this.content}) : super(key: key);

  final String name;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, HomeProvider>(
        builder: (context, userProvider, homeProvider, child) {
      return Container(
        decoration: BoxDecoration(
            color: Coloring.bg_blue, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 20),
              child: Text("우리 가족에게 한마디",
                  style: TextStyle(
                    color: Coloring.gray_0,
                    fontSize: Font.size_largeText,
                    fontWeight: Font.weight_semiBold,
                  )),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15, right: 12, bottom: 20, left: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      "lib/assets/images/family/profile/dad_profile.png",
                      width: 56,
                      height: 56,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Font.size_mediumText,
                          fontWeight: Font.weight_bold,
                        )),
                    SizedBox(
                      width: 200,
                      child: Text(
                         "$content\n",
                        style: TextStyle(
                          color: Coloring.gray_0,
                          fontSize: Font.size_largeText,
                          fontWeight: Font.weight_medium,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 2,
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
