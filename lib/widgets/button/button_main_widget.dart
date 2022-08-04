import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/constant/shadowing.dart';

class ButtonMainWidget extends StatelessWidget {
  const ButtonMainWidget({Key? key, required this.title, required this.onPressed}) : super(key: key);
  final String title;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          gradient: Coloring.main,
          borderRadius: BorderRadius.circular(99),
          boxShadow: [Shadowing.yellow],
        ),
        child: TextButton(
            onPressed: onPressed,
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Font.size_largeText,
                  fontWeight: Font.weight_bold),
            )));
  }
}
