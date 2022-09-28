import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/constant/user_colors.dart';

import 'package:modak_flutter_app/data/model/user.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/ui/user/user_family_modify_screen.dart';
import 'package:modak_flutter_app/ui/user/user_landing_VM.dart';
import 'package:modak_flutter_app/widgets/button/button_main_widget.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:modak_flutter_app/widgets/user/user_profile_widget.dart';
import 'package:provider/provider.dart';

class UserLandingScreen extends StatelessWidget {
  const UserLandingScreen({Key? key}) : super(key: key);

  Text function(User familyMember) {
    return Text("");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, UserLandingVM>(
        builder: (context, userProvider, provider, child) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: headerDefaultWidget(title: "유저"),
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
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: userProvider.familyMembersWithoutMe.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 32, bottom: 16),
                              child: UserProfileWidget(
                                user: userProvider.familyMembersWithoutMe[index],
                                onPressed: () {
                                  Get.to(UserFamilyModifyScreen(familyMember: userProvider.familyMembersWithoutMe[index]));
                                },
                              ),
                            );
                          })
                    ] +
                    <Widget>[
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
                          title: "초대 하기",
                          onPressed: () {
                            Get.toNamed("/user/invitation/landing");
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 48),
                        child: ButtonMainWidget(
                          title: "설정",
                          onPressed: () {
                            Get.toNamed("/user/settings");
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
