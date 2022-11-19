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
  const HomeFamilyTalkWidget({Key? key, required this.dateTime, this.isNone = false, this.isPast = false})
      : super(key: key);

  final DateTime dateTime;
  final bool isNone;
  final bool isPast;

  @override
  State<HomeFamilyTalkWidget> createState() => _HomeFamilyTalkWidgetState();
}

class _HomeFamilyTalkWidgetState extends State<HomeFamilyTalkWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider, UserProvider>(builder: (context, homeProvider, userProvider, child) {
      bool isWritten = homeProvider.todayTalkMap[Date.getFormattedDate(dateTime: widget.dateTime)]
              ?[userProvider.me!.memberId] !=
          null;
      return GestureDetector(
        onTap: () {
          if (!isWritten) {
            Get.to(HomeTalkWriteScreen());
          } else {
            Get.to(HomeTalkViewScreen());
          }
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
            gradient: Coloring.notice,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "오늘의 한 마디",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Font.size_h3,
                  fontWeight: Font.weight_bold,
                ),
              ),
              if (isWritten || widget.isPast)
                Column(
                  children: homeProvider.todayTalkMap[Date.getFormattedDate(dateTime: widget.dateTime)]?.entries
                          .map(
                            (MapEntry<int, String> item) => HomeFamilyTalkItemWidget(
                              name: userProvider.findUserById(item.key)?.name ?? "익명",
                              talk: item.value,
                            ),
                          )
                          .toList() ??
                      [],
                ),
              if (!isWritten && !widget.isPast)
                Text(
                  "한마디를 작성하고 확인해보세요",
                  style: TextStyle(
                    color: Coloring.gray_10,
                    fontSize: Font.size_smallText,
                    fontWeight: Font.weight_medium,
                    height: 2.5,
                  ),
                ),
              if ((homeProvider.todayTalkMap[Date.getFormattedDate(dateTime: widget.dateTime)] ?? {}).isEmpty &&
                  widget.isPast)
                Text(
                  "작성된 한마디가 없습니다",
                  style: TextStyle(
                    color: Coloring.gray_10,
                    fontSize: Font.size_smallText,
                    fontWeight: Font.weight_medium,
                    height: 2.5,
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}

class HomeFamilyTalkItemWidget extends StatelessWidget {
  const HomeFamilyTalkItemWidget({Key? key, required this.name, required this.talk}) : super(key: key);

  final String name;
  final String talk;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "$name   ",
              style: TextStyle(
                color: Colors.black,
                fontSize: Font.size_mediumText,
                fontWeight: Font.weight_medium,
              ),
            ),
            Expanded(
                child: Text(
              talk,
              style: TextStyle(
                color: Colors.black,
                fontSize: Font.size_mediumText,
                fontWeight: Font.weight_regular,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
