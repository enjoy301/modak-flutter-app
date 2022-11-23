import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/constant/shadowing.dart';
import 'package:modak_flutter_app/utils/easy_style.dart';
import 'package:modak_flutter_app/widgets/button/button_main_widget.dart';
import 'package:modak_flutter_app/widgets/common/scalable_text_widget.dart';

class HomeItemWidget extends StatelessWidget {
  const HomeItemWidget(
      {Key? key,
      required this.title,
      required this.des,
      required this.onPressed,
      this.type,
      this.isPointGiven = false})
      : super(key: key);

  final String? type;
  final String title;
  final String des;
  final Function() onPressed;
  final bool isPointGiven;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              Shadowing.grey,
              Shadowing.grey,
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (type != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: ScalableTextWidget(
                  type!,
                  style: EasyStyle.text(Colors.blueAccent, Font.size_smallText,
                      Font.weight_semiBold),
                ),
              ),
            ScalableTextWidget(
              "$title ",
              style: TextStyle(
                  height: 1,
                  color: Colors.black,
                  fontSize: Font.size_h3,
                  fontWeight: Font.weight_bold,
                  overflow: TextOverflow.ellipsis),
              maxLines: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                des,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Font.size_smallText,
                  fontWeight: Font.weight_medium,
                ),
                maxLines: 3,
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox.shrink(),
            ),
            if (isPointGiven)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: ButtonMainWidget(
                  title: "클릭해서 확인",
                  onPressed: onPressed,
                  height: 40,
                ),
              ),
            if (!isPointGiven)
              Container(
                padding: EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.arrow_forward_ios_rounded),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
