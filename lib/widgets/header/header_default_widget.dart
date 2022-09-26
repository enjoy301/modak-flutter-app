import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';

AppBar headerDefaultWidget({
  String title = "",
  FunctionalIcon leading = FunctionalIcon.none,
  FunctionalIcon trailing = FunctionalIcon.none,
  Function()? onClickLeading,
  Function()? onClickTrailing,
  Color? bgColor = Colors.white,
  PreferredSizeWidget? bottom,
}) {
  Map<FunctionalIcon, Image> iconData = {
    FunctionalIcon.none: Image.asset(
      "lib/assets/functional_image/ic_back.png",
      width: 0,
      height: 0,
    ),
    FunctionalIcon.back: Image.asset(
      "lib/assets/functional_image/ic_back.png",
      width: 32,
      height: 32,
    ),
    FunctionalIcon.close: Image.asset(
      "lib/assets/functional_image/ic_close.png",
      width: 32,
      height: 32,
    ),
    FunctionalIcon.stack: Image.asset(
      "lib/assets/functional_image/ic_stack.png",
      width: 32,
      height: 32,
    ),
    FunctionalIcon.trash: Image.asset(
      "lib/assets/functional_image/ic_trash.png",
      width: 32,
      height: 32,
    ),
    FunctionalIcon.user: Image.asset(
      "lib/assets/functional_image/ic_user.png",
      width: 32,
      height: 32,
    ),
  };
  return AppBar(
    leading: TextButton(
      onPressed: onClickLeading,
      child: iconData[leading]!,
    ),
    actions: [
      TextButton(
        onPressed: onClickTrailing,
        child: iconData[trailing]!,
      )
    ],
    centerTitle: true,
    title: Text(title,
        style: TextStyle(
          color: Colors.black,
          fontSize: Font.size_largeText,
          fontWeight: Font.weight_bold,
        )),
    backgroundColor: bgColor,
    elevation: 0,
    bottom: bottom,
  );
}
