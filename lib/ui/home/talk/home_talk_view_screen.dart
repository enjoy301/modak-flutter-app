import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/home_provider.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/utils/date.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeTalkViewScreen extends StatefulWidget {
  const HomeTalkViewScreen({Key? key}) : super(key: key);

  @override
  State<HomeTalkViewScreen> createState() => _HomeTalkViewScreenState();
}

class _HomeTalkViewScreenState extends State<HomeTalkViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, HomeProvider>(
        builder: (context, userProvider, homeProvider, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: headerDefaultWidget(
            title: "오늘의 한 마디",
            leading: FunctionalIcon.back,
            onClickLeading: () {
              Get.back();
            }),
        body: Column(
          children: [
            TableCalendar(
              onPageChanged: (focusedDay) {
              },
                locale: 'ko-KR',
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                ),
                focusedDay: homeProvider.focusedDateTime,
                selectedDayPredicate: (datetime) =>
                    homeProvider.selectedDateTime == datetime,
                firstDay: DateTime(2017),
                lastDay: DateTime(2023),
                onDaySelected: (selectedDay, focusedDay) async {
                  await homeProvider.getTodayTalk(focusedDay);
                  homeProvider.selectedDateTime = selectedDay;
                  homeProvider.focusedDateTime = focusedDay;
                }),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: homeProvider
                              .todayTalkMap[Date.getFormattedDate(
                                  dateTime: homeProvider.selectedDateTime)]
                              ?.keys
                              .map((key) {
                            return Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  bottom: BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  )
                                )
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text( userProvider.findUserById(key)?.name ?? "익명", style: TextStyle(
                                    color: Coloring.gray_0,
                                    fontSize: Font.size_mediumText,
                                    fontWeight: Font.weight_semiBold,
                                  ),),
                                  Text(homeProvider.todayTalkMap[Date.getFormattedDate(
                                      dateTime: homeProvider.selectedDateTime)]![key]!, style: TextStyle(
                                    color: Coloring.gray_0,
                                    fontSize: Font.size_largeText,
                                    fontWeight: Font.weight_regular,
                                    height: 2,
                                  ),),
                                ],
                              ),
                            );
                          }).toList() ??
                          [],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
