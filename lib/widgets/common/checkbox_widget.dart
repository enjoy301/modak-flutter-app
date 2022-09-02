import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';

class CheckboxWidget extends StatefulWidget {
  const CheckboxWidget(
      {Key? key, required this.value, required this.onChanged})
      : super(key: key);

  final bool value;
  final Function(bool?) onChanged;

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          gradient: Coloring.sub_purple,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Theme(
          data: ThemeData(
            unselectedWidgetColor: Color(0x00F6DFDF),
          ),
          child: Checkbox(
            activeColor: Color(0x00F6DFDF),
            value: widget.value,
            onChanged: widget.onChanged,
          ),
        ));
  }
}
