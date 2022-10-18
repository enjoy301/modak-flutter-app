import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/data/dto/user.dart';
import 'package:modak_flutter_app/main.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/ui/user/user_family_modify_screen.dart';
import 'package:modak_flutter_app/widgets/button/button_main_widget.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:modak_flutter_app/widgets/modal/modal_check_widget.dart';
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
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: headerDefaultWidget(
              title: "유저",
              customLeading: IconButton(
                  onPressed: () {
                    Get.toNamed("/user/settings");
                  },
                  icon: Icon(
                    Icons.settings,
                    color: Coloring.gray_0,
                  ))),
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
                          color: Coloring.gray_40,
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
                      if (userProvider.familyMembersWithoutMe.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Container(
                            width: double.infinity,
                            height: 1,
                            color: Coloring.gray_40,
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: ButtonMainWidget(
                          title: "초대 코드",
                          onPressed: () {
                            Get.toNamed("/user/invitation/landing");
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 48),
                        child: ButtonMainWidget(
                          title: "로그아웃",
                          onPressed: () {
                            modalCheckwidget(context,
                                title: "정말 로그아웃 하시겠습니까?",
                                okText: "로그아웃",
                                noText: "취소", onOkPressed: () {
                              userProvider.logout(context);
                              Get.deleteAll();
                            }, onNoPressed: () {
                              Get.back();
                            });
                          },
                          // onPressed: provider.navigateToFamilyInfo(),
                        ),
                      ),
                    ],
              ),
            ),
          ));
    });
  }
}
