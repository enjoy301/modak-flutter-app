import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/constant/shadowing.dart';
import 'package:modak_flutter_app/widgets/common/scalable_text_widget.dart';

class ButtonMainWidget extends StatelessWidget {
  const ButtonMainWidget(
      {Key? key,
      required this.title,
      required this.onPressed,
      this.isValid = true,
      this.width = double.infinity,
      this.height = 60})
      : super(key: key);
  final String title;
  final Function()? onPressed;
  final bool isValid;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: isValid ? Coloring.sub_purple : null,
          color: isValid ? null : Coloring.gray_50,
          borderRadius: BorderRadius.circular(99),
          boxShadow: isValid ? [Shadowing.purple] : [Shadowing.grey],
        ),
        child: TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: isValid ? onPressed : null,
            child: ScalableTextWidget(
              title,
              style: TextStyle(
                  color: isValid ? Colors.white : Coloring.gray_30,
                  fontSize: Font.size_largeText,
                  fontWeight: Font.weight_bold),
            )));
  }
}
