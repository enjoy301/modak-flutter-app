import 'package:flutter/material.dart';

class FunctionOnWayWidget extends StatefulWidget {
  const FunctionOnWayWidget({Key? key}) : super(key: key);

  @override
  State<FunctionOnWayWidget> createState() => _FunctionOnWayWidget();
}

class _FunctionOnWayWidget extends State<FunctionOnWayWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}
