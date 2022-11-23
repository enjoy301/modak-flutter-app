import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/ui/user/invitation/user_invitation_input_VM.dart';
import 'package:modak_flutter_app/utils/easy_style.dart';
import 'package:modak_flutter_app/widgets/common/scalable_text_widget.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:provider/provider.dart';

class UserInvitationInputScreen extends StatefulWidget {
  const UserInvitationInputScreen({Key? key}) : super(key: key);

  @override
  State<UserInvitationInputScreen> createState() =>
      _UserInvitationInputScreenState();
}

class _UserInvitationInputScreenState extends State<UserInvitationInputScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserInvitationInputVM>(builder: (context, provider, child) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Coloring.gray_50,
          appBar: headerDefaultWidget(
              title: "코드 입력",
              trailing: FunctionalIcon.close,
              onClickTrailing: () {
                Get.back();
              }),
          body: Column(
            children: [
              Expanded(flex: 1, child: SizedBox()),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    "lib/assets/images/others/launcher_icon.png",
                                    width: 65,
                                    height: 65,
                                  ),
                                  ScalableTextWidget(
                                    "모닥 코드",
                                    style: EasyStyle.text(
                                        Coloring.gray_10,
                                        Font.size_mediumText,
                                        Font.weight_medium),
                                  ),
                                  Transform.scale(
                                    scale: 0.8,
                                    child: TextFormField(
                                      onChanged: (String text) {
                                        provider.familyCode = text;
                                      },
                                      textAlign: TextAlign.center,
                                      cursorColor: Coloring.gray_50,
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Coloring.gray_50,
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 0),
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white, width: 0),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          )),
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
                            onTap: () async {
                              bool isSuccessful =
                                  await provider.updateFamilyCode(context);
                              if (isSuccessful) {
                                Get.offAllNamed("/auth/splash");
                              }
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
                                "입력 하기",
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
              Visibility(
                visible: false,
                maintainState: true,
                maintainAnimation: true,
                maintainSize: true,
                child: Text(
                  "가족의 코드를 알고 계시나요?",
                  style: EasyStyle.text(Coloring.gray_10, Font.size_largeText,
                      Font.weight_medium),
                  textAlign: TextAlign.center,
                ),
              ),
              Visibility(
                visible: false,
                maintainState: true,
                maintainAnimation: true,
                maintainSize: true,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 90),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed("/user/invitation/input");
                    },
                    child: Text(
                      "코드 직접 입력하기",
                      style: TextStyle(
                          color: Coloring.point_pureorange,
                          fontSize: Font.size_largeText,
                          fontWeight: Font.weight_bold,
                          height: 2),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
