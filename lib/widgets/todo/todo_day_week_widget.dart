import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/widgets/common/scalable_text_widget.dart';

class TodoDayWeekWidget extends StatelessWidget {
  const TodoDayWeekWidget({
    Key? key,
    required this.dayOfTheWeek,
    required this.onPressed,
    this.isEnabled = true,
  }) : super(key: key);

  final DayOfTheWeek dayOfTheWeek;
  final Function() onPressed;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    Map<DayOfTheWeek, dynamic> data = {
      DayOfTheWeek.sun: {
        "title": "일",
        "color": Coloring.bg_red,
      },
      DayOfTheWeek.mon: {
        "title": "월",
        "color": Coloring.bg_orange,
      },
      DayOfTheWeek.tue: {
        "title": "화",
        "color": Coloring.bg_yellow,
      },
      DayOfTheWeek.wed: {
        "title": "수",
        "color": Coloring.bg_green,
      },
      DayOfTheWeek.thu: {
        "title": "목",
        "color": Coloring.bg_blue,
      },
      DayOfTheWeek.fri: {
        "title": "금",
        "color": Coloring.bg_purple,
      },
      DayOfTheWeek.sat: {
        "title": "토",
        "color": Coloring.bg_pink,
      },
    };

    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isEnabled ? Coloring.todo_orange : Coloring.gray_50,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
              child: ScalableTextWidget(
            data[dayOfTheWeek]['title'],
            style: TextStyle(
              color: Coloring.gray_10,
              fontSize: Font.size_smallText,
              fontWeight: Font.weight_regular,
            ),
          )),
        ),
      ),
    );
  }
}
