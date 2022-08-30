import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/ui/user/user_modify_screen.dart';
import 'package:modak_flutter_app/utils/extension_util.dart';
import 'package:modak_flutter_app/widgets/button/button_main_small_widget.dart';
import 'package:provider/provider.dart';

class UserProfileWidget extends StatefulWidget {
  const UserProfileWidget({Key? key}) : super(key: key);

  @override
  State<UserProfileWidget> createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, provider, child) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 18,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Coloring.bg_orange,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: Image.asset(
                "lib/assets/images/family/profile/dau_profile.png",
                width: 56,
                height: 56,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        provider.name ?? "",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Font.size_largeText,
                          fontWeight: Font.weight_semiBold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: SizedBox(
                          width: 10,
                          height: 10,
                          child: CircleAvatar(
                            backgroundColor: provider.color,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "${provider.familyType.toDisplayString()} | ${provider.birthDay != null ? provider.birthDay!.month : 0}월 ${provider.birthDay != null ? provider.birthDay!.day : 0}일",
                      style: TextStyle(
                        color: Coloring.gray_10,
                        fontSize: Font.size_smallText,
                        fontWeight: Font.weight_regular,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(child: Text("")),
            ButtonMainSmallWidget(
              title: "수정하기",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserModifyScreen()));
              },
            ),
          ],
        ),
      );
    });
  }
}
