import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/home_provider.dart';
import 'package:modak_flutter_app/utils/easy_style.dart';
import 'package:modak_flutter_app/widgets/common/scalable_text_widget.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class UserInvitationLandingScreen extends StatefulWidget {
  const UserInvitationLandingScreen({Key? key}) : super(key: key);

  @override
  State<UserInvitationLandingScreen> createState() =>
      _UserInvitationLandingScreenState();
}

class _UserInvitationLandingScreenState
    extends State<UserInvitationLandingScreen> {
  bool isClipTappedDown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Coloring.gray_50,
      appBar: headerDefaultWidget(
          title: "가족 초대하기",
          trailing: FunctionalIcon.close,
          onClickTrailing: () {
            Get.back();
          }),
      body: Consumer<HomeProvider>(builder: (context, homeProvider, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(),
            ),
            ClipRect(
              child: Container(
                width: double.infinity,
                height: 350,
                margin: EdgeInsets.symmetric(horizontal: 45),
                decoration: BoxDecoration(
                  gradient: Coloring.main,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Container(
                    width: double.infinity,
                    height: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13.5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 30, right: 30, left: 30, bottom: 30),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  "lib/assets/images/others/launcher_icon.png",
                                  width: 65,
                                  height: 65,
                                ),
                                ScalableTextWidget(
                                  "모닥 코드",
                                  style: EasyStyle.text(Coloring.gray_10,
                                      Font.size_largeText, Font.weight_medium),
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    Clipboard.setData(ClipboardData(
                                        text: homeProvider.familyCode));
                                    Fluttertoast.showToast(
                                        msg: "클립보드에 복사되었습니다.");
                                  },
                                  onTapDown: (tapDownDetails) {
                                    setState(() {
                                      isClipTappedDown = true;
                                    });
                                  },
                                  onTapUp: (tapDownDetails) {
                                    setState(() {
                                      isClipTappedDown = false;
                                    });
                                  },
                                  child: ScalableTextWidget(
                                    homeProvider.familyCode ?? "",
                                    style: TextStyle(
                                      color: isClipTappedDown
                                          ? Colors.grey[700]!.withOpacity(0.5)
                                          : Colors.grey[700],
                                      fontSize: Font.size_subTitle,
                                      fontWeight: Font.weight_medium,
                                      decoration: TextDecoration.underline,
                                      decorationThickness: 1.5,
                                    ),
                                  ),
                                ),
                                Text(
                                  "가족과 함께\n모닥으로 따뜻한 이야기를 남겨보세요",
                                  style: EasyStyle.text(
                                      Coloring.gray_20,
                                      Font.size_mediumText,
                                      Font.weight_regular),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Share.share(
                                "[MODAK]\n가족 방에 초대되셨습니다\n초대코드: ${homeProvider.familyCode ?? ""}");
                          },
                          child: Container(
                            width: double.infinity,
                            height: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: Coloring.main,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                            child: ScalableTextWidget(
                              "공유하기",
                              style: EasyStyle.text(Colors.white,
                                  Font.size_largeText, Font.weight_semiBold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(),
            ),
            Text(
              "가족의 코드를 알고 계시나요?",
              style: EasyStyle.text(
                  Coloring.gray_10, Font.size_largeText, Font.weight_medium),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 90),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed("/user/invitation/input");
                },
                child: ScalableTextWidget(
                  "코드 직접 입력하기",
                  style: TextStyle(
                    color: Coloring.point_pureorange,
                    fontSize: Font.size_largeText,
                    fontWeight: Font.weight_bold,
                    height: 2,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
