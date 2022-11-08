import 'package:flutter/material.dart';

class CheckboxWidget extends StatefulWidget {
  const CheckboxWidget({Key? key, required this.value, required this.onChanged}) : super(key: key);

  final bool value;
  final Function(bool?) onChanged;

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 24,
        height: 24,
        // decoration: BoxDecoration(
        //   color: widget.value ? null : Colors.white,
        //   gradient: widget.value ? Coloring.sub_purple : null,
        //   borderRadius: BorderRadius.circular(5),
        // ),
        child: Theme(
          data: ThemeData(
              // unselectedWidgetColor: Color(0x00F6DFDF),
              ),
          child: Checkbox(
            activeColor: Colors.deepPurpleAccent[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(width: 0.1),
            ),
            value: widget.value,
            onChanged: widget.onChanged,
          ),
        ));
  }
}
