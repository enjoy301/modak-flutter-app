import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/font.dart';

class EasyStyle {
  static text(Color color, double fontSize, FontWeight fontWeight) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static errorText() {
    return TextStyle(
      color: Colors.red,
      fontSize: Font.size_caption,
      fontWeight: Font.weight_semiBold,
    );
  }
}
