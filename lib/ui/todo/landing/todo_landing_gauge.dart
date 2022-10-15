import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/todo_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class TodoLandingGauge extends StatefulWidget {
  const TodoLandingGauge({Key? key}) : super(key: key);

  @override
  State<TodoLandingGauge> createState() => _TodoLandingGaugeState();
}

class _TodoLandingGaugeState extends State<TodoLandingGauge> {
  @override
  Widget build(BuildContext context) {
    var total = 100;
    return Consumer<TodoProvider>(builder: (context, todoProvider, child) {
      return Padding(
        padding: const EdgeInsets.only(top: 24, right: 30, left: 30),
        child: Column(
          children: [
            LinearPercentIndicator(
              percent: (todoProvider.todoCount % total) / total,
              lineHeight: 10,
              backgroundColor: Coloring.gray_40,
              linearGradient: Coloring.sub_purple as LinearGradient,
              barRadius: Radius.circular(10),
            ),
            Row(
              children: [
                Text((total * (todoProvider.todoCount ~/ 100)).toString(),
                    style: TextStyle(
                      color: Coloring.gray_10,
                      fontSize: Font.size_caption,
                      fontWeight: Font.weight_regular,
                    )),
                Expanded(flex: todoProvider.todoCount % 100, child: Text("")),
                Text(
                  context.watch<TodoProvider>().todoCount.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Font.size_caption,
                    fontWeight: Font.weight_regular,
                  ),
                ),
                Expanded(flex: total * (todoProvider.todoCount ~/ 100 + 1).toInt() - todoProvider.todoCount, child: Text("")),
                Text(
                  (total * (todoProvider.todoCount / 100 + 1).toInt()).toString(),
                  style: TextStyle(
                    color: Coloring.gray_10,
                    fontSize: Font.size_caption,
                    fontWeight: Font.weight_regular,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
