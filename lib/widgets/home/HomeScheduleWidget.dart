import 'package:flutter/material.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';

class HomeScheduleWidget extends StatefulWidget {
  const HomeScheduleWidget(
      {Key? key, required this.title, required this.day, this.isNone = false})
      : super(key: key);

  final String title;
  final int day;
  final bool isNone;

  @override
  State<HomeScheduleWidget> createState() => _HomeScheduleWidgetState();
}

class _HomeScheduleWidgetState extends State<HomeScheduleWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        right: 30,
        left: 30,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Coloring.bg_orange,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(
              LightIcons.Calendar,
              color: Coloring.gray_10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                widget.isNone ? "아직 설정된 기념일이 없습니다." : widget.title,
                style: TextStyle(
                  color: Coloring.gray_10,
                  fontSize: Font.size_smallText,
                  fontWeight: Font.weight_regular,
                ),
              ),
            ),
            Expanded(child: Text("")),
            widget.isNone
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 9,),
                    decoration: BoxDecoration(
                      gradient: Coloring.main,
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Text("등록", style: TextStyle(
                      color: Colors.white,
                      fontSize: Font.size_smallText,
                      fontWeight: Font.weight_semiBold,
                    )),
                  )
                : Text(
                    "D-${widget.day.toString()}",
                    style: TextStyle(
                      color: Coloring.gray_10,
                      fontSize: Font.size_smallText,
                      fontWeight: Font.weight_semiBold,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
