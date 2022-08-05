import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/constant/shadowing.dart';

class ButtonMainWidget extends StatelessWidget {
  const ButtonMainWidget(
      {Key? key,
      required this.title,
      required this.onPressed,
      this.isValid = true})
      : super(key: key);
  final String title;
  final Function()? onPressed;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          gradient: isValid ? Coloring.main : null,
          color: isValid ? null : Coloring.gray_50,
          borderRadius: BorderRadius.circular(99),
          boxShadow: isValid ? [Shadowing.yellow] : [Shadowing.grey],
        ),
        child: TextButton(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
            onPressed: isValid ? onPressed : null,
            child: Text(
              title,
              style: TextStyle(
                  color: isValid ? Colors.white : Coloring.gray_30,
                  fontSize: Font.size_largeText,
                  fontWeight: Font.weight_bold),
            )));
  }
}
