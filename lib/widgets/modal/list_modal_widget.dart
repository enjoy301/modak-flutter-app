import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/widgets/common/scalable_text_widget.dart';

void listModalWidget(BuildContext context, Map<String, Function()> buttons,
    {String buttonStyleType = "default", String textStyleType = "default"}) {
  final Map<String, ButtonStyle> buttonStyles = {
    "default": TextButton.styleFrom(
      foregroundColor:
          MaterialStateColor.resolveWith((states) => Coloring.gray_0),
      backgroundColor: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 20),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    )
  };
  final Map<String, TextStyle> textStyles = {
    "default": TextStyle(
      color: Coloring.gray_10,
      fontSize: Font.size_subTitle,
      fontWeight: Font.weight_semiBold,
    ),
  };
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          content: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: buttons.keys
                    .map((key) => Column(
                          children: [
                            Container(
                              height: 1,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              color: Coloring.gray_30,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                  style: buttonStyles[buttonStyleType],
                                  onPressed: buttons[key]!,
                                  child: ScalableTextWidget(
                                    key,
                                    style: textStyles[textStyleType]!,
                                  )),
                            ),
                          ],
                        ))
                    .toList(),
              ),
            ),
          ),
        );
      });
}
