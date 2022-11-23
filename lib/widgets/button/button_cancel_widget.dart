import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/constant/shadowing.dart';
import 'package:modak_flutter_app/widgets/common/scalable_text_widget.dart';

class ButtonCancelWidget extends StatelessWidget {
  const ButtonCancelWidget(
      {Key? key,
      required this.title,
      required this.onPressed,
      this.width = double.infinity,
      this.height = 60})
      : super(key: key);

  final String title;
  final Function()? onPressed;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Coloring.gray_40,
        borderRadius: BorderRadius.circular(99),
        boxShadow: [Shadowing.grey],
      ),
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: onPressed,
        child: ScalableTextWidget(
          title,
          style: TextStyle(
              height: 1.5,
              color: Colors.black,
              fontSize: Font.size_largeText,
              fontWeight: Font.weight_bold),
        ),
      ),
    );
  }
}
