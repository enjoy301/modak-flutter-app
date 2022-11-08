import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/home_provider.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/utils/easy_style.dart';
import 'package:modak_flutter_app/widgets/common/colored_safe_area.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:modak_flutter_app/widgets/home/home_family_talk_widget.dart';
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
    return Consumer2<UserProvider, HomeProvider>(builder: (context, userProvider, homeProvider, child) {
      return ColoredSafeArea(
        child: Scaffold(
          backgroundColor: Coloring.gray_50,
          appBar: headerDefaultWidget(
              title: "오늘의 한 마디",
              leading: FunctionalIcon.back,
              onClickLeading: () {
                Get.back();
              }),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: TableCalendar(
                  onPageChanged: (focusedDay) {},
                  locale: 'ko-KR',
                  headerStyle: HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                      leftChevronIcon: Icon(LightIcons.ArrowLeft2, color: Colors.black, size: 24),
                      rightChevronIcon: Icon(LightIcons.ArrowRight2, color: Colors.black, size: 24),
                      titleTextStyle: EasyStyle.text(Colors.black, Font.size_largeText, Font.weight_bold),
                      headerMargin: EdgeInsets.only(bottom: 20)),
                  calendarStyle: CalendarStyle(
                    isTodayHighlighted: false,
                    defaultTextStyle: EasyStyle.text(Colors.black, Font.size_largeText, Font.weight_regular),
                    weekendTextStyle: EasyStyle.text(Colors.black, Font.size_largeText, Font.weight_regular),
                    selectedDecoration: BoxDecoration(
                      gradient: Coloring.notice,
                      shape: BoxShape.circle,
                    ),
                  ),
                  focusedDay: homeProvider.focusedDateTime,
                  selectedDayPredicate: (datetime) => homeProvider.selectedDateTime == datetime,
                  firstDay: DateTime(2017),
                  lastDay: DateTime(2023),
                  onDaySelected: (selectedDay, focusedDay) async {
                    await homeProvider.getTodayTalk(focusedDay);
                    homeProvider.selectedDateTime = selectedDay;
                    homeProvider.focusedDateTime = focusedDay;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: IgnorePointer(
                  ignoring: true,
                  child: HomeFamilyTalkWidget(
                    dateTime: homeProvider.focusedDateTime,
                    isPast: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
