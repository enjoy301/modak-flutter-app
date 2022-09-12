import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/shadowing.dart';
import 'package:modak_flutter_app/provider/todo_provider.dart';
import 'package:modak_flutter_app/ui/todo/landing/todo_landing_VM.dart';
import 'package:modak_flutter_app/ui/todo/landing/todo_landing_calendar.dart';
import 'package:modak_flutter_app/ui/todo/landing/todo_landing_gauge.dart';
import 'package:modak_flutter_app/ui/todo/landing/todo_landing_list.dart';
import 'package:modak_flutter_app/ui/todo/write/todo_write_screen.dart';
import 'package:provider/provider.dart';

// ignore: depend_on_referenced_packages
import 'package:animations/animations.dart';

class TodoLandingScreen extends StatelessWidget {
  const TodoLandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<TodoProvider, TodoLandingVM>(
        builder: (context, todoProvider, provider, child) {
      return Scaffold(
        body: Column(
          children: [
            TodoLandingCalendar(),
            TodoLandingGauge(),
            TodoLandingList(),
          ],
        ),
        floatingActionButton: OpenContainer(
          closedBuilder: (_, openedContainer) => Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: Coloring.sub_purple,
              boxShadow: [
                Shadowing.purple,
              ],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          openBuilder: (_, openedContainer) => TodoWriteScreen(),
          closedElevation: 0,
        ),
      );
    });
  }
}
