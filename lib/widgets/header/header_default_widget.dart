import 'package:flutter/material.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';

AppBar headerDefaultWidget() {
  return AppBar(
    leading: Container(
      margin: EdgeInsets.all(10),
      color: Colors.red,
      child: IconButton(
        onPressed: () {
          print("안녕");
        },
        icon: Icon(
          LightIcons.ArrowLeft2,
          size: 16,
          color: Coloring.gray_0,
        ),
      ),
    ),
    centerTitle: true,
    title: Text("Modak",
        style: TextStyle(
          color: Colors.black,
          fontSize: Font.size_largeText,
          fontWeight: Font.weight_bold,
        )),
    backgroundColor: Colors.white,
    elevation: 0,
  );
}
