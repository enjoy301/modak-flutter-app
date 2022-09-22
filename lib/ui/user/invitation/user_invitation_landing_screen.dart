import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/home_provider.dart';
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
  bool isInputTappedDown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: headerDefaultWidget(
        title: "가족 초대하기",
          trailing: FunctionalIcon.close,
          onClickTrailing: () {
            Get.back();
          }),
      body: Consumer<HomeProvider>(builder: (context, homeProvider, child) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Text("가족과 함께해서,\n더 많은 컨텐츠를 즐겨보세요 ",
                  style: TextStyle(), textAlign: TextAlign.center),
              Image.asset(
                "lib/assets/images/others/splash_modak_fire.png",
                height: 200,
              ),
              Text("당신의 코드"),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Clipboard.setData(
                      ClipboardData(text: homeProvider.familyCode));
                  Fluttertoast.showToast(msg: "클립보드에 복사되었습니다.");
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
                child: Text(
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
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: GestureDetector(
                  onTap: () {
                    Share.share("[MODAK]\n가족 방에 초대되셨습니다\n초대코드: ${homeProvider.familyCode}" ?? "");
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    decoration: BoxDecoration(
                      color: Color(0xFFC5B697),
                      borderRadius: BorderRadius.circular(6)
                    ),
                    child: Text("공유하기", style: TextStyle(
                      color: Colors.white,
                      fontSize: Font.size_largeText,
                      fontWeight: Font.weight_regular,
                    )),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(),
              ),
              Text(
                "혹은, \n가족의 코드를 알고 계시나요?",
                style: TextStyle(),
                textAlign: TextAlign.center,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed("/user/invitation/input");
                },
                onTapDown: (tapDownDetails) {
                  setState(() {
                    isInputTappedDown = true;
                  });
                },
                onTapUp: (tapDownDetails) {
                  setState(() {
                    isInputTappedDown = false;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 48),
                  child: Text(
                    "상대방 코드 입력",
                    style: TextStyle(
                        color: isInputTappedDown
                            ? Colors.grey[700]!.withOpacity(0.5)
                            : Colors.grey[700],
                        fontSize: Font.size_subTitle,
                        fontWeight: Font.weight_medium,
                        height: 2),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
