import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/ui/todo/write/write_when_screen.dart';
import 'package:modak_flutter_app/widgets/button/button_main_widget.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:modak_flutter_app/widgets/input/input_date_widget.dart';
import 'package:modak_flutter_app/widgets/input/input_select_widget.dart';
import 'package:modak_flutter_app/widgets/todo/todo_day_week_widget.dart';

class TodoWriteScreen extends StatelessWidget {
  const TodoWriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: headerDefaultWidget(
            title: "할 일 추가하기",
            leading: FunctionalIcon.back,
            onClickLeading: () {
              Navigator.pop(context);
            }),
        body: ExpandableNotifier(
          child: Padding(
            padding: const EdgeInsets.only(right: 30, left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "기본 설정",
                      style: TextStyle(
                        color: Coloring.gray_10,
                        fontSize: Font.size_mediumText,
                        fontWeight: Font.weight_semiBold,
                      ),
                    ),
                  ),
                ),
                // InputTextWidget(),
                InputSelectWidget(
                    title: "담당",
                    contents: "contents",
                    buttons: [],
                    leftIconData: LightIcons.Profile),
                InputDateWidget(
                    title: "날짜",
                    contents: "contents",
                    onChanged: (DateTime dateTime) {},
                    currTime: DateTime.now()),
                InputSelectWidget(
                  title: "언제",
                  contents: "contents",
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => WriteWhenScreen()));
                  },
                  leftIconData: LightIcons.TimeCircle,
                ),
                ExpandableButton(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "추가 설정",
                          style: TextStyle(
                            color: Coloring.gray_10,
                            fontSize: Font.size_mediumText,
                            fontWeight: Font.weight_semiBold,
                          ),
                        ),
                        Expandable(
                          collapsed: Icon(LightIcons.ArrowDown2),
                          expanded: Icon(
                            LightIcons.ArrowUp2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expandable(
                    theme: ExpandableThemeData(
                      animationDuration: Duration(milliseconds: 0),
                    ),
                    collapsed: Text(""),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              TodoDayWeekWidget(
                                dayOfTheWeek: DayOfTheWeek.sun,
                                onPressed: () {},
                              ),
                              TodoDayWeekWidget(
                                dayOfTheWeek: DayOfTheWeek.mon,
                                onPressed: () {},
                              ),
                              TodoDayWeekWidget(
                                dayOfTheWeek: DayOfTheWeek.tue,
                                onPressed: () {},
                              ),
                              TodoDayWeekWidget(
                                dayOfTheWeek: DayOfTheWeek.wed,
                                onPressed: () {},
                              ),
                              TodoDayWeekWidget(
                                dayOfTheWeek: DayOfTheWeek.thu,
                                onPressed: () {},
                              ),
                              TodoDayWeekWidget(
                                dayOfTheWeek: DayOfTheWeek.fri,
                                onPressed: () {},
                              ),
                              TodoDayWeekWidget(
                                dayOfTheWeek: DayOfTheWeek.sat,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                        Text("메모 (옵션)"),
                        // InputTextWidget(
                        //   hint: "할 일 내용",
                        //   minLines: 2,
                        //   maxLines: 5,
                        // ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20,),
        child: ButtonMainWidget(
          title: "등록", onPressed: () async {

        },
        ),
      ),
    );
  }

  bool changeColor() {
    return true;
  }
}
