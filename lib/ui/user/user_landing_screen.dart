import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/constant/shadowing.dart';
import 'package:modak_flutter_app/data/dto/user.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/ui/user/user_family_modify_screen.dart';
import 'package:modak_flutter_app/utils/easy_style.dart';
import 'package:modak_flutter_app/widgets/common/colored_safe_area.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:modak_flutter_app/widgets/modal/theme_modal_widget.dart';
import 'package:modak_flutter_app/widgets/user/user_profile_widget.dart';
import 'package:provider/provider.dart';

class UserLandingScreen extends StatelessWidget {
  const UserLandingScreen({Key? key}) : super(key: key);

  Text function(User familyMember) {
    return Text("");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      return ColoredSafeArea(
        color: Colors.white,
        child: Scaffold(
            backgroundColor: Coloring.gray_50,
            appBar: headerDefaultWidget(
              title: "가족 정보",
              customLeading: IconButton(
                onPressed: () {
                  Get.toNamed("/user/settings");
                },
                icon: Icon(
                  Icons.settings,
                  color: Coloring.gray_0,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 30,
                  left: 30,
                ),
                child: Column(
                  children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 32, bottom: 16),
                          child: UserProfileWidget(
                            user: userProvider.me,
                            onPressed: () {
                              Get.toNamed("/user/modify");
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Container(
                            width: double.infinity,
                            height: 1,
                            color: Coloring.gray_10,
                          ),
                        )
                      ] +
                      userProvider.familyMembersWithoutMe
                          .map((familyMember) => Padding(
                                padding:
                                    const EdgeInsets.only(top: 16, bottom: 16),
                                child: UserProfileWidget(
                                  user: familyMember,
                                  onPressed: () {
                                    Get.to(UserFamilyModifyScreen(
                                        familyMember: familyMember));
                                  },
                                ),
                              ))
                          .toList() +
                      <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed("/user/invitation/landing");
                            },
                            child: Container(
                              width: double.infinity,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(22),
                                boxShadow: [Shadowing.bottom],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(LightIcons.Plus),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Text("가족 초대하기"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 120, bottom: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  themeModalWidget(
                                    context,
                                    title: "정말 회원 탈퇴 하시겠습니까?",
                                    okText: "회원 탈퇴",
                                    cancelText: "취소",
                                    onOkPress: () {
                                      userProvider.withdraw(context);
                                    },
                                    onCancelPress: () {
                                      Get.back();
                                    },
                                  );
                                },
                                child: Text(
                                  "회원 탈퇴",
                                  style: EasyStyle.text(Coloring.gray_10,
                                      Font.size_mediumText, Font.weight_medium),
                                ),
                              ),
                              Container(
                                width: .8,
                                height: 35,
                                color: Coloring.gray_10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  themeModalWidget(
                                    context,
                                    title: "정말 로그아웃 하시겠습니까?",
                                    okText: "로그아웃",
                                    cancelText: "취소",
                                    onOkPress: () {
                                      userProvider.logout(context);
                                    },
                                    onCancelPress: () {
                                      Get.back();
                                    },
                                  );
                                },
                                child: Text(
                                  "로그아웃",
                                  style: EasyStyle.text(Coloring.gray_10,
                                      Font.size_mediumText, Font.weight_medium),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                ),
              ),
            )),
      );
    });
  }
}
