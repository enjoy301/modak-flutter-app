import 'package:flutter/material.dart';
import 'package:modak_flutter_app/provider/todo_provider.dart';
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
    return Consumer<TodoProvider>(
      builder: (context, provider, child) {
        return TableCalendar(
            locale: 'ko-KR',
            focusedDay: provider.focusedDateTime,
            selectedDayPredicate: (datetime) => provider.focusedDateTime == datetime,
            firstDay: DateTime.utc(DateTime.now().year - 20,1,1),
            lastDay: DateTime.utc(DateTime.now().year + 20,1,1),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() => {
                    provider.setFocusedDatetime(selectedDay),
                  });
            },
            calendarFormat: CalendarFormat.week,
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
            ),
            calendarBuilders:
                CalendarBuilders(defaultBuilder: (context, day, focusedDay) {
              print(day);
              return Center(
                  child: Text(
                day.day.toString(),
                style: TextStyle(color: Colors.black),
              ));
            }, selectedBuilder: (context, day, focusedDay) {
              return Center(
                  child: Text(
                day.day.toString(),
                style: TextStyle(color: Colors.blue),
              ));
            }, dowBuilder: (context, day) {
              return null;
            }, todayBuilder: (context, day, focusedDay) {
              return Center(
                  child: Text(
                day.day.toString(),
                style: TextStyle(color: Colors.red),
              ));
            }, markerBuilder: (context, day, focusedDay) {
              return Positioned(
                bottom: 1,
                child: Row(
                  children: [
                    Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.pinkAccent, borderRadius: BorderRadius.circular(10.0)),),
                    Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(10.0)),),
                    Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(10.0)),),
                    Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.yellowAccent, borderRadius: BorderRadius.circular(10.0)),),
                  ],
                ),
              );
            }));
      }
    );
  }
}
