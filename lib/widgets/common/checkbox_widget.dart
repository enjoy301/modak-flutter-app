import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';

class CheckboxWidget extends StatefulWidget {
  const CheckboxWidget(
      {Key? key,
      required this.value,
      required this.onChanged,
      this.color = "purple"})
      : super(key: key);

  final bool value;
  final Function(bool?) onChanged;
  final String color;

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  final Map<String, Color> colorMap = {
    "orange": Coloring.todo_orange,
    "purple": Colors.deepPurpleAccent[100]!,
  };
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.2,
      child: SizedBox(
          width: 24,
          height: 24,
          child: Theme(
            data: ThemeData(
              unselectedWidgetColor: Coloring.gray_30,
            ),
            child: Checkbox(
              activeColor: colorMap[widget.color],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(width: 0.1),
              ),
              value: widget.value,
              onChanged: widget.onChanged,
            ),
          )),
    );
  }
}
