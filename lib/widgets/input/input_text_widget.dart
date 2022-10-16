import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';

class InputTextWidget extends StatefulWidget {
  const InputTextWidget({
    Key? key,
    required this.textEditingController,
    this.hint = "",
    this.onChanged,
    this.isSuffix = false,
    this.onClickSuffix,
    this.minLines = 1,
    this.maxLines = 1,
    this.isBlocked = false,
  }) : super(key: key);
  final TextEditingController textEditingController;
  final String hint;
  final Function(String text)? onChanged;
  final bool isSuffix;
  final Function()? onClickSuffix;
  final int minLines;
  final int maxLines;
  final bool isBlocked;
  @override
  // ignore: no_logic_in_create_state
  State<InputTextWidget> createState() => _InputTextWidgetState();
}

class _InputTextWidgetState extends State<InputTextWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.isBlocked,
      child: SizedBox(
        child: TextFormField(
          autofocus: false,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          controller: widget.textEditingController,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15),
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: Coloring.gray_20,
                fontSize: Font.size_mediumText,
                fontWeight: Font.weight_regular,
              ),
              filled: true,
              fillColor: widget.isBlocked ? Coloring.gray_30 : Coloring.gray_50,
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
                        widget.textEditingController.clear();
                      },
                      icon: Icon(
                        Icons.close,
                        color: Coloring.gray_10,
                        size: 20,
                      ))
                  : null),
          cursorColor: Coloring.gray_0,
          style: TextStyle(
            color: widget.isBlocked ? Coloring.gray_0 : Coloring.gray_10,
            fontSize: Font.size_mediumText,
            fontWeight: Font.weight_regular,
          ),
        ),
      ),
    );
  }
}
