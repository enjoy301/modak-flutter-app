import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/shadowing.dart';
import 'package:modak_flutter_app/provider/todo_provider.dart';
import 'package:modak_flutter_app/ui/todo/landing/todo_landing_calendar.dart';
import 'package:modak_flutter_app/ui/todo/landing/todo_landing_list.dart';
import 'package:modak_flutter_app/ui/todo/write/todo_write_screen.dart';
import 'package:provider/provider.dart';

class TodoLandingScreen extends StatelessWidget {
  const TodoLandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(builder: (context, todoProvider, child) {
      return Scaffold(
          body: Column(
            children: [
              TodoLandingCalendar(),
              TodoLandingList(),
            ],
          ),
          floatingActionButton: GestureDetector(
            onTap: () {
              Get.to(
                () => TodoWriteScreen(),
              );
            },
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
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ));
    });
  }
}
