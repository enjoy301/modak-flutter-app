import 'package:flutter/material.dart';

class FunctionOnWayWidget extends StatefulWidget {
  const FunctionOnWayWidget({Key? key}) : super(key: key);

  @override
  State<FunctionOnWayWidget> createState() => _FunctionOnWayWidgetState();
}

class _FunctionOnWayWidgetState extends State<FunctionOnWayWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("onway"),
    );
  }
}
