import 'package:flutter/material.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/todo_provider.dart';
import 'package:modak_flutter_app/widgets/todo/todo_date_widget.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class TodoLandingCalendar extends StatefulWidget {
  const TodoLandingCalendar({Key? key}) : super(key: key);

  @override
  State<TodoLandingCalendar> createState() => _TodoLandingCalendarState();
}

class _TodoLandingCalendarState extends State<TodoLandingCalendar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(builder: (context, provider, child) {
      return Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        decoration: BoxDecoration(gradient: Coloring.main),
        child: TableCalendar(
            locale: 'ko-KR',
            calendarStyle: CalendarStyle(
              rowDecoration: BoxDecoration(
                color: Colors.transparent,
              ),
            ),
            focusedDay: provider.focusedDateTime,
            daysOfWeekVisible: false,
            rowHeight: 104,
            selectedDayPredicate: (datetime) =>
                provider.focusedDateTime == datetime,
            firstDay: DateTime.utc(DateTime.now().year - 20, 1, 1),
            lastDay: DateTime.utc(DateTime.now().year + 20, 1, 1),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() => {
                    provider.setFocusedDatetime(selectedDay),
                  });
            },
            calendarFormat: CalendarFormat.week,
            headerStyle: HeaderStyle(
                titleCentered: true,
                titleTextFormatter: (view, all) {
                  return "${view.month.toString()}월 ${view.year.toString()}년";
                },
                formatButtonVisible: false,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: Font.size_largeText,
                  fontWeight: Font.weight_bold,
                ),
                leftChevronIcon:
                    Icon(LightIcons.ArrowLeft2, color: Colors.white, size: 22),
                rightChevronIcon:
                    Icon(LightIcons.ArrowRight2, color: Colors.white, size: 22),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                )),
            calendarBuilders:
                CalendarBuilders(defaultBuilder: (context, day, focusedDay) {
              return TodoDateWidget(
                selectedDay: day,
                isSelected: false,
              );
            }, selectedBuilder: (context, day, focusedDay) {
              return TodoDateWidget(
                selectedDay: day,
                isSelected: true,
              );
            }, outsideBuilder: (context, day, focusedDay) {
              return TodoDateWidget(
                selectedDay: day,
                isSelected: false,
              );
            }, todayBuilder: (context, day, focusedDay) {
              return TodoDateWidget(
                selectedDay: day,
                isSelected: false,
                isToday: true,
              );
            })),
      );
    });
  }
}


