import 'package:flutter/material.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/constant/shadowing.dart';
import 'package:modak_flutter_app/screens/common/common_invitation_screen.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:modak_flutter_app/widgets/user/user_profile_widget.dart';
import 'package:modak_flutter_app/widgets/user/user_simple_profile_widget.dart';

class UserFamilyScreen extends StatefulWidget {
  const UserFamilyScreen({Key? key}) : super(key: key);

  @override
  State<UserFamilyScreen> createState() => _UserFamilyScreenState();
}

class _UserFamilyScreenState extends State<UserFamilyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: headerDefaultWidget(
          title: "우리 가족 정보",
          leading: FunctionalIcon.close,
          onClickLeading: () {
            Navigator.pop(context);
          }),
      body: Padding(
        padding: const EdgeInsets.only(top: 32, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UserSimpleProfileWidget(family: FamilyType.dad,),
                  UserSimpleProfileWidget(family: FamilyType.mom,),
                  UserSimpleProfileWidget(family: FamilyType.son,),
                  UserSimpleProfileWidget(family: FamilyType.dau,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CommonInvitationScreen()));
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: Coloring.sub_purple,
                          boxShadow: [Shadowing.purple],
                          borderRadius: BorderRadius.circular(1000),
                        ),
                        child: Icon(Icons.add),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Coloring.gray_40,
              ),
            ),
            UserProfileWidget(),
            Padding(
              padding: const EdgeInsets.only(top: 48, bottom: 32),
              child: Text("최근 인증 사진", style: TextStyle(
                color: Coloring.gray_10,
                fontSize: Font.size_mediumText,
                fontWeight: Font.weight_semiBold,
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
