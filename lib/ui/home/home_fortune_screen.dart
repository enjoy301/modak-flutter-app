import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/home_provider.dart';
import 'package:modak_flutter_app/widgets/common/scalable_text_widget.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:provider/provider.dart';

class HomeFortuneScreen extends StatelessWidget {
  const HomeFortuneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        return FutureBuilder(
          future: Future(() async {
            if (homeProvider.todayFortune == null) {
              await homeProvider.getTodayFortune();
            }
          }),
          builder: (context, snapshot) {
            return Scaffold(
              backgroundColor: Coloring.bg_orange,
              appBar: headerDefaultWidget(
                title: "오늘의 운세",
                leading: FunctionalIcon.back,
                onClickLeading: () {
                  Get.back();
                },
                bgColor: Coloring.bg_orange,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    ScalableTextWidget(homeProvider.todayFortune ?? "", style: TextStyle(
                      color: Colors.black,
                      fontSize: Font.size_largeText,
                      fontWeight: Font.weight_semiBold
                    ), textAlign: TextAlign.center,),
                  ],
                ),
              ),
            );
          }
        );
      }
    );
  }
}
