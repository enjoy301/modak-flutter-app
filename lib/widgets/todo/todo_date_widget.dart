import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/todo_provider.dart';
import 'package:modak_flutter_app/utils/extension_util.dart';

class TodoDateWidget extends StatelessWidget {
  const TodoDateWidget(
      {Key? key,
        required this.colors,
      required this.selectedDay,
      required this.isSelected,
      this.isToday = false})
      : super(key: key);

  final List<String> colors;
  final DateTime selectedDay;
  final bool isSelected;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    List<String> daysOfWeek = ["", "월", "화", "수", "목", "금", "토", "일"];

    return Center(
        child: Container(
      margin: EdgeInsets.only(right: 5, bottom: 24, left: 5),
      padding: EdgeInsets.only(top: 11, bottom: 12),
      width: double.infinity,
      height: double.infinity,
      decoration: isSelected
          ? BoxDecoration(
              color: Coloring.bg_orange,
              borderRadius: BorderRadius.circular(100),
            )
          : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            daysOfWeek[selectedDay.weekday],
            style: isSelected
                ? TextStyle(
                    color: isToday ? Coloring.info_pink : Coloring.gray_10,
                    fontSize: Font.size_smallText,
                    fontWeight: Font.weight_semiBold,
                  )
                : TextStyle(
                    color: isToday ? Coloring.info_pink : Colors.white,
                    fontSize: Font.size_smallText,
                    fontWeight: Font.weight_medium,
                  ),
          ),
          Text(
            selectedDay.day.toString(),
            textAlign: TextAlign.center,
            style: isSelected
                ? TextStyle(
                    color: isToday ? Coloring.info_pink : Coloring.gray_10,
                    fontSize: Font.size_mediumText,
                    fontWeight: Font.weight_semiBold)
                : TextStyle(
                    color: isToday ? Coloring.info_pink : Colors.white,
                    fontSize: Font.size_mediumText,
                    fontWeight: Font.weight_medium),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: colors
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1.5),
                      child: SizedBox(
                        width: 4,
                        height: 4,
                        child: CircleAvatar(
                          backgroundColor: e.toColor()!,
                        ),
                      ),
                    ))
                .toList(),
          )
        ],
      ),
    ));
  }
}
