import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/widgets/home/HomeScheduleWidget.dart';
import 'package:modak_flutter_app/widgets/home/HomeTodoWidget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeLandingScreen extends StatefulWidget {
  const HomeLandingScreen({Key? key}) : super(key: key);

  @override
  State<HomeLandingScreen> createState() => _HomeLandingScreenState();
}

class _HomeLandingScreenState extends State<HomeLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
          body: SlidingUpPanel(
        maxHeight: MediaQuery.of(context).size.height -
            70 -
            MediaQuery.of(context).padding.top,
        minHeight: MediaQuery.of(context).size.height * 1.9 / 3,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        panelBuilder: (controller) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 35),
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Coloring.gray_30,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  primary: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          HomeScheduleWidget(title: "엄마 생일", day: 120),
                          HomeScheduleWidget(title: "수능", day: 63,),
                          HomeScheduleWidget(title: "", day: 0, isNone: true,),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 32, left: 30, bottom: 16),
                        child: Text(
                          "오늘 할 일",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Font.size_largeText,
                              fontWeight: Font.weight_semiBold),
                        ),
                      ),
                      Column(
                        children: [
                          HomeTodoWidget(title: "은종이 데리러 가기",),
                          HomeTodoWidget(title: "설거지하기",),
                          HomeTodoWidget(title: "빨래하기",),
                          HomeTodoWidget(title: "엄마 생일 선물 준비하기",),
                          HomeTodoWidget(title: "저녁 식사 준비하기",),
                          HomeTodoWidget(title: "코딩 존나 하기",),
                          HomeTodoWidget(title: "", isNone: true),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        body: Stack(
          children: [
            Container(
                decoration: BoxDecoration(gradient: Coloring.main),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 16,
                      right: 38,
                      left: 38),
                  child: Column(children: [
                    Image.asset(
                      "lib/assets/images/others/family_illust.png",
                      width: double.infinity,
                    ),
                  ]),
                )),
            Positioned(
              top: MediaQuery.of(context).padding.top + 15,
              right: 30,
              child: GestureDetector(
                onTap: () {},
                child: Image.asset(
                  "lib/assets/functional_image/ic_user.png",
                  width: 32,
                  height: 32,
                ),
              ),
            ),
          ],
        ),
      ));
    });
  }
}
