import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';

class InputTextWidget extends StatefulWidget {
  const InputTextWidget(
      {Key? key,
      this.initialValue = "",
        this.hint = "",
      this.onChanged,
      this.isSuffix = false,
      this.onClickSuffix})
      : super(key: key);
  final String initialValue;
  final String hint;
  final Function(String text)? onChanged;
  final bool isSuffix;
  final Function()? onClickSuffix;

  @override
  // ignore: no_logic_in_create_state
  State<InputTextWidget> createState() => _InputTextWidgetState();
}

class _InputTextWidgetState extends State<InputTextWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: _controller,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.hint,
            hintStyle: TextStyle(
              color: Coloring.gray_20,
              fontSize: Font.size_mediumText,
              fontWeight: Font.weight_regular,
            ),
            filled: true,
            fillColor: Coloring.gray_50,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Coloring.gray_50),
                borderRadius: BorderRadius.circular(16)),
            focusColor: Coloring.bg_red,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.5, color: Coloring.gray_30),
                borderRadius: BorderRadius.circular(16)),
            suffixIcon: widget.isSuffix
                ? IconButton(
                    onPressed: () {
                      widget.onClickSuffix!.call();
                      _controller.clear();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Coloring.gray_10,
                      size: 20,
                    ))
                : null),
        cursorColor: Coloring.gray_0,
        style: TextStyle(
          color: Coloring.gray_10,
          fontSize: Font.size_mediumText,
          fontWeight: Font.weight_regular,
        ),
      ),
    );
  }
}
