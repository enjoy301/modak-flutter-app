import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/data/dto/today_content.dart';
import 'package:modak_flutter_app/provider/home_provider.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/ui/common/common_web_screen.dart';
import 'package:modak_flutter_app/utils/easy_style.dart';
import 'package:modak_flutter_app/widgets/home/home_family_talk_widget.dart';
import 'package:modak_flutter_app/widgets/home/home_item_widget.dart';
import 'package:provider/provider.dart';

class HomeLandingScreen extends StatefulWidget {
  const HomeLandingScreen({Key? key}) : super(key: key);

  @override
  State<HomeLandingScreen> createState() => _HomeLandingScreenState();
}

class _HomeLandingScreenState extends State<HomeLandingScreen> {
  List<String> headerTitle = ["오늘 우리 가족은", "오늘의 컨텐츠"];

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider, UserProvider>(
        builder: (context, homeProvider, userProvider, child) {
      return Scaffold(
        backgroundColor: Coloring.gray_50,
        appBar: AppBar(
          backgroundColor: Coloring.gray_50,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              "모닥",
              style: TextStyle(
                color: Colors.black,
                fontSize: Font.size_h1,
                fontWeight: Font.weight_bold,
              ),
            ),
          ),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton(
                  onPressed: () {
                    Get.toNamed("/home/notification");
                  },
                  icon: Icon(
                    LightIcons.Notification,
                    color: Colors.black,
                  )),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                HomePictureWidget(),
                HomeFamilyTalkWidget(
                  dateTime: DateTime.now(),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 9),
                  child: LayoutGrid(
                    columnSizes: [1.fr, 1.fr],
                    rowSizes: [auto, auto],
                    rowGap: 20,
                    columnGap: 20,
                    children: [
                      HomeItemWidget(
                        title: "하루 한줄",
                        des: "모닥이 알려주는\n오늘의 문장",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "하루 한줄",
                                    style: EasyStyle.text(Colors.black,
                                        Font.size_h3, Font.weight_bold),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Image.asset(
                                        "lib/assets/functional_image/ic_close.png",
                                        width: 32,
                                        height: 32,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "모닥이 알려주는 오늘의 문장",
                                    style: EasyStyle.text(
                                        Colors.black,
                                        Font.size_smallText,
                                        Font.weight_medium),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    margin: EdgeInsets.only(top: 15),
                                    decoration: BoxDecoration(
                                      color: Coloring.gray_40,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      homeProvider.todayFortune?.content ??
                                          "운세 없음",
                                      style: EasyStyle.text(
                                          Colors.black,
                                          Font.size_largeText,
                                          Font.weight_medium),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        isPointGiven: true,
                      ),
                      HomeItemWidget(
                        title: "우편함",
                        des: "편지를 작성하고\n보내보세요",
                        onPressed: () {
                          Get.toNamed("/chat/letter/landing");
                        },
                      ),
                      ...homeProvider.todayContents
                          .map(
                            (TodayContent content) => HomeItemWidget(
                              type: content.type,
                              title: content.title,
                              des: content.desc,
                              onPressed: () {
                                Get.to(CommonWebScreen(
                                    title: content.title, link: content.url));
                              },
                            ),
                          )
                          .toList(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

class HomePictureWidget extends StatelessWidget {
  const HomePictureWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 25),
      margin: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Color(0XFFD9D9D9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(LightIcons.Plus),
          SizedBox(
            height: 12,
          ),
          Text("가족사진 등록하기"),
        ],
      ),
    );
  }
}
