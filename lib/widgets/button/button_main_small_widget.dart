import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/widgets/common/scalable_text_widget.dart';

class ButtonMainSmallWidget extends StatefulWidget {
  const ButtonMainSmallWidget({Key? key, required this.title, required this.onPressed}) : super(key: key);

  final String title;
  final Function() onPressed;
  @override
  State<ButtonMainSmallWidget> createState() => _ButtonMainSmallWidgetState();
}

class _ButtonMainSmallWidgetState extends State<ButtonMainSmallWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 9,
        ),
        decoration: BoxDecoration(
          gradient: Coloring.main,
          borderRadius: BorderRadius.circular(99),
        ),
        child: ScalableTextWidget(widget.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: Font.size_smallText,
              fontWeight: Font.weight_semiBold,
            )),
      ),
    );
  }
}
