import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';

class ButtonTextWidget extends StatelessWidget {
  const ButtonTextWidget(
      {Key? key, required this.text, required this.onPressed, this.isValid = true, this.isColorStatic = false})
      : super(key: key);

  final String text;
  final Function() onPressed;
  final bool isValid;
  final bool isColorStatic;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isValid,
      child: TextButton(
          onPressed: onPressed,
          style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => Coloring.gray_50)),
          child: Text(
            text,
            style: TextStyle(
              color: isColorStatic
                  ? Coloring.gray_20
                  : isValid
                      ? Coloring.gray_0
                      : Coloring.gray_40,
              fontSize: Font.size_largeText,
              fontWeight: Font.weight_bold,
            ),
          )),
    );
  }
}
