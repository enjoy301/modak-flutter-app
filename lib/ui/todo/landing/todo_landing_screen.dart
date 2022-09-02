import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/shadowing.dart';
import 'package:modak_flutter_app/ui/todo/landing/todo_landing_calendar.dart';
import 'package:modak_flutter_app/ui/todo/landing/todo_landing_gauge.dart';
import 'package:modak_flutter_app/ui/todo/landing/todo_landing_list.dart';

class TodoLandingScreen extends StatelessWidget {
  const TodoLandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            TodoLandingCalendar(),
            TodoLandingGauge(),
            TodoLandingList(),
          ],
        ),
        floatingActionButton: GestureDetector(
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: Coloring.sub_purple,
              boxShadow: [
                Shadowing.purple,
              ],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(Icons.add, color: Colors.white,),
          ),
          onTap: () async {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => const TodoWriteScreen()));
          },
        ));
  }
}
