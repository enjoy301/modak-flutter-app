import 'package:flutter/material.dart';
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
    return Consumer<TodoProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(flex: provider.todoCount, child: Text("")),
                  Text(context.watch<TodoProvider>().todoCount.toString()),
                  Expanded(flex: total - provider.todoCount, child: Text("")),
                ],
              ),
              LinearPercentIndicator(
                percent: provider.todoCount / total,
                lineHeight: 15,
                backgroundColor: Colors.lightBlueAccent,
                barRadius: Radius.circular(10),
              ),
              Row(
                children: [
                  Text("0"),
                  Expanded(flex: 1, child: Text("")),
                  Text(total.toString()),
                ],
              )
            ],
          ),
        );
      }
    );
  }
}
