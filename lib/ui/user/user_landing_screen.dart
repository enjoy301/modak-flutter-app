import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/ui/common/common_invitation_screen.dart';
import 'package:modak_flutter_app/ui/user/user_family_screen.dart';
import 'package:modak_flutter_app/ui/user/user_landing_VM.dart';
import 'package:modak_flutter_app/widgets/button/button_main_widget.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:modak_flutter_app/widgets/user/user_profile_widget.dart';
import 'package:provider/provider.dart';

class UserLandingScreen extends StatelessWidget {
  const UserLandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, UserLandingVM>(
        builder: (context, userProvider, provider, child) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: headerDefaultWidget(title: "유저"),
          body: Padding(
            padding: const EdgeInsets.only(
              top: 32,
              right: 30,
              left: 30,
            ),
            child: Column(
              children: [
                UserProfileWidget(
                  user: userProvider.me,
                  onPressed: () {
                    Get.toNamed("/user/modify");
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: Coloring.gray_40,
                  ),
                ),
                ButtonMainWidget(
                  title: "가족 정보 보기",
                  onPressed: () {
                    Get.to(() => UserFamilyScreen());
                  },
                  // onPressed: provider.navigateToFamilyInfo(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ButtonMainWidget(
                    title: "초대 하기",
                    onPressed: () {
                      Get.to(() => CommonInvitationScreen(
                            withSkipButton: false,
                          ));
                    },
                  ),
                )
              ],
            ),
          ));
    });
  }
}
