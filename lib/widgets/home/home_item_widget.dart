import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/constant/shadowing.dart';
import 'package:modak_flutter_app/widgets/button/button_main_widget.dart';

class HomeItemWidget extends StatelessWidget {
  const HomeItemWidget(
      {Key? key, required this.title, required this.des, required this.onPressed, this.isPointGiven = false})
      : super(key: key);

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
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [
          Shadowing.grey,
          Shadowing.grey,
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: Font.size_h3, fontWeight: Font.weight_bold),
            ),
            Expanded(
              flex: 1,
              child: SizedBox.shrink(),
            ),
            Text(
              des,
              style: TextStyle(
                color: Colors.black,
                fontSize: Font.size_smallText,
                fontWeight: Font.weight_medium,
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox.shrink(),
            ),
            if (isPointGiven)
              ButtonMainWidget(
                title: "클릭해서 확인",
                onPressed: onPressed,
                height: 40,
              ),
            if (!isPointGiven)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.arrow_forward_ios_rounded),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
