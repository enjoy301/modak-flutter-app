import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';

class ChatInputWidget extends StatelessWidget {
  const ChatInputWidget(
      {Key? key,
      required this.textEditingController,
      this.hint = "메시지를 입력하세요",
      this.textAlign = TextAlign.start,
      this.autofocus = false,
      this.focusNode,
      this.onTap,
      this.onChanged})
      : super(key: key);

  final TextEditingController textEditingController;
  final String hint;
  final TextAlign textAlign;
  final bool autofocus;
  final FocusNode? focusNode;
  final Function()? onTap;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      constraints: BoxConstraints(maxHeight: 100),
      child: TextFormField(
        autofocus: autofocus,
        focusNode: focusNode,
        style: TextStyle(
          fontSize: Font.size_largeText,
          fontWeight: Font.weight_regular,
        ),
        textAlign: textAlign,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        controller: textEditingController,
        onTap: onTap,
        onChanged: onChanged,
        cursorColor: Coloring.gray_0,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Coloring.gray_20),
            contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(17),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Coloring.gray_30, width: 2),
              borderRadius: BorderRadius.circular(17),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Coloring.gray_20, width: 2),
              borderRadius: BorderRadius.circular(17),
            ),
            filled: true,
            fillColor: Coloring.gray_50),
      ),
    );
  }
}
