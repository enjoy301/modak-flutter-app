import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/home_provider.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/ui/home/talk/home_talk_view_screen.dart';
import 'package:modak_flutter_app/ui/home/talk/home_talk_write_screen.dart';
import 'package:modak_flutter_app/utils/date.dart';
import 'package:provider/provider.dart';

class HomeFamilyTalkWidget extends StatefulWidget {
  const HomeFamilyTalkWidget(
      {Key? key, required this.name, required this.content})
      : super(key: key);

  final String name;
  final String content;

  @override
  State<HomeFamilyTalkWidget> createState() => _HomeFamilyTalkWidgetState();
}

class _HomeFamilyTalkWidgetState extends State<HomeFamilyTalkWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, HomeProvider>(
        builder: (context, userProvider, homeProvider, child) {
      return Padding(
        padding: const EdgeInsets.only(top: 20, right: 18, bottom: 5, left: 18),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            padding: MaterialStateProperty.all(
              EdgeInsets.zero,
            ),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
          ),
          onPressed: () {
            if (homeProvider.todayTalkMap[Date.getFormattedDate()]
                    ?[userProvider.me!.memberId] ==
                null) {
              Get.to(HomeTalkWriteScreen());
            } else {
              Get.to(HomeTalkViewScreen());
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "가족 대화",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: Font.size_smallText,
                      fontWeight: Font.weight_bold),
                ),
                Text(
                  "우리 가족 오늘의 한 마디",
                  style: TextStyle(
                      color: Coloring.gray_0,
                      fontSize: Font.size_largeText,
                      fontWeight: Font.weight_bold),
                ),
                SizedBox(
                  height: 10,
                ),
                FamilyTalkNotWritten(
                  homeProvider: homeProvider,
                  userProvider: userProvider,
                ),
                if (homeProvider.todayTalkMap[Date.getFormattedDate()]
                        ?[userProvider.me!.memberId] !=
                    null)
                  FamilyTalkWritten(
                    homeProvider: homeProvider,
                    userProvider: userProvider,
                  ),
                if (homeProvider.todayTalkMap[Date.getFormattedDate()]
                        ?[userProvider.me!.memberId] !=
                    null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        "모아보기 >",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Colors.grey[900]!.withOpacity(0.5)),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class FamilyTalkWritten extends StatelessWidget {
  const FamilyTalkWritten(
      {Key? key, required this.homeProvider, required this.userProvider})
      : super(key: key);

  final HomeProvider homeProvider;
  final UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: homeProvider.todayTalkMap[Date.getFormattedDate()]?.keys
                .map((int member) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          "lib/assets/images/family/profile/${userProvider.findUserById(member)!.role.toLowerCase()}_profile.png",
                          width: 56,
                          height: 56,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userProvider.findUserById(member)?.name ?? "익명",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Font.size_mediumText,
                                  fontWeight: Font.weight_bold,
                                  height: 2),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${homeProvider.todayTalkMap[Date.getFormattedDate()]![member]!}\n",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Font.size_largeText,
                                  fontWeight: Font.weight_regular),
                              maxLines: 2,
                            ),
                          ]),
                    ),
                  ],
                ),
              );
            }).toList() ??
            []);
  }
}

class FamilyTalkNotWritten extends StatelessWidget {
  const FamilyTalkNotWritten(
      {Key? key, required this.homeProvider, required this.userProvider})
      : super(key: key);

  final HomeProvider homeProvider;
  final UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text(
            homeProvider.todayTalkMap[Date.getFormattedDate()]
                        ?[userProvider.me!.memberId] ==
                    null
                ? "오늘의 한 마디를\n 작성해 주세요"
                : "오늘도 가족 모두\n 화이팅 입니다",
            style: TextStyle(
              color: Coloring.gray_0,
              fontSize: Font.size_largeText,
              fontWeight: Font.weight_bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Flexible(
          child: Image.asset(
            "lib/assets/images/others/il_family_talk.png",
          ),
        ),
      ],
    );
  }
}
