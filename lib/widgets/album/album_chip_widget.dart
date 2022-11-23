import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/utils/easy_style.dart';
import 'package:modak_flutter_app/widgets/common/scalable_text_widget.dart';

class AlbumChipWidget extends StatelessWidget {
  const AlbumChipWidget(
      {required this.title, required this.isSelected, Key? key})
      : super(key: key);

  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: EdgeInsets.only(top: 9, right: 6, bottom: 0, left: 6),
      decoration: BoxDecoration(
          color: isSelected ? Coloring.gray_20 : Coloring.gray_40,
          borderRadius: BorderRadius.circular(30)),
      child: ScalableTextWidget(
        title,
        style: EasyStyle.text(
          isSelected ? Colors.white : Coloring.gray_10,
          Font.size_mediumText,
          Font.weight_regular,
        ),
      ),
    );
  }
}
