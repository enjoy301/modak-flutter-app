import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/data/dto/today_content.dart';
import 'package:modak_flutter_app/provider/home_provider.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/ui/common/common_medias_screen.dart';
import 'package:modak_flutter_app/ui/common/common_web_screen.dart';
import 'package:modak_flutter_app/utils/easy_style.dart';
import 'package:modak_flutter_app/widgets/common/scalable_text_widget.dart';
import 'package:modak_flutter_app/widgets/home/home_family_talk_widget.dart';
import 'package:modak_flutter_app/widgets/home/home_item_widget.dart';
import 'package:provider/provider.dart';

class HomeLandingScreen extends StatefulWidget {
  const HomeLandingScreen({Key? key}) : super(key: key);

  @override
  State<HomeLandingScreen> createState() => _HomeLandingScreenState();
}

class _HomeLandingScreenState extends State<HomeLandingScreen> {
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
            Stack(
              children: [
                if (userProvider.getNewNotificationNumber() > 0)
                  Positioned(
                    top: 5,
                    right: 20,
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: IconButton(
                    onPressed: () {
                      Get.toNamed("/home/notification");
                    },
                    icon: Icon(
                      LightIcons.Notification,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: homeProvider.init,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
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
                          title: "하루 한 줄",
                          des: "모닥이 알려주는\n오늘의 문장",
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      32.0,
                                    ),
                                  ),
                                ),
                                contentPadding: EdgeInsets.only(
                                  left: 24.0,
                                  top: 10.0,
                                  right: 24.0,
                                  bottom: 28.0,
                                ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ScalableTextWidget(
                                      "하루 한 줄",
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
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20),
                                      margin: EdgeInsets.only(top: 15),
                                      decoration: BoxDecoration(
                                        gradient: Coloring.notice,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 20),
                                        child: ScalableTextWidget(
                                          homeProvider.todayFortune?.content ??
                                              "운세 없음",
                                          style: EasyStyle.text(
                                            Colors.black,
                                            Font.size_largeText,
                                            Font.weight_bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
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
        ),
      );
    });
  }
}

class HomePictureWidget extends StatelessWidget {
  const HomePictureWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          return homeProvider.familyImage == null
              ? GestureDetector(
                  onTap: () {
                    homeProvider.bottomTabIndex = 3;
                  },
                  child: Container(
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
                        Text("앨범에서 가족사진 등록하기"),
                      ],
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    Get.to(CommonMediasScreen(
                      files: [homeProvider.familyImage!],
                    ));
                  },
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.width,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.file(homeProvider.familyImage!,
                          width: double.infinity, fit: BoxFit.fitWidth),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
