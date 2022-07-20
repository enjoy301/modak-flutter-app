import 'package:flutter/material.dart';
import 'package:modak_flutter_app/models/todo_model.dart';
import 'package:modak_flutter_app/provider/todo_provider.dart';
import 'package:modak_flutter_app/screens/todo/landing/todo_landing_calendar.dart';
import 'package:modak_flutter_app/screens/todo/landing/todo_landing_gauge.dart';
import 'package:modak_flutter_app/screens/todo/landing/todo_landing_list.dart';
import 'package:provider/provider.dart';

class TodoLandingScreen extends StatelessWidget {
  const TodoLandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TodoLandingCalendar(),
            TodoLandingGauge(),
            TodoLandingList(),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        child: Container(
          width: 50,
          height: 50,
          color: Colors.red,
        ),
        onTap: () {
          context.read<TodoProvider>().add(TodoModel(title: "제목", desc: "이것은 내용입니다. 이것은 내용입니다. 이것은 내용입니다. 이것은 내용입니다. 이것은 내용입니다.", tags: ["점심 먹고 땡", "주말"]));
          // Navigator.push(context, MaterialPageRoute(builder: (context) => const TodoWriteScreen()));
        },
      )
    );
  }
}
