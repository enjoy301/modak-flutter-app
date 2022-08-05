import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/constant/shadowing.dart';

class AuthIntroductionWidget extends StatefulWidget {
  const AuthIntroductionWidget({Key? key, required this.name})
      : super(key: key);

  final String name;

  @override
  State<AuthIntroductionWidget> createState() => _AuthIntroductionWidgetState();
}

class _AuthIntroductionWidgetState extends State<AuthIntroductionWidget> {
  final data = {
    "washer": {
      "title": "집안일",
      "des": "집안일을 공유하고 도와주세요",
      "imagePath": "lib/assets/images/others/img_graphic_washer.png",
      "gradient": Coloring.main,
      "shadow": Shadowing.yellow,
    },
    "album": {
      "title": "가족 앨범",
      "des": "가족들과의 추억을 저장하세요",
      "imagePath": "lib/assets/images/others/img_graphic_album.png",
      "gradient": Coloring.sub_purple,
      "shadow": Shadowing.yellow,
    },
    "chat": {
      "title": "공유",
      "des": "가족들만의 소통 공간을 이용해보세요",
      "imagePath": "lib/assets/images/others/img_graphic_chat.png",
      "gradient": Coloring.sub_blue,
      "shadow": Shadowing.yellow,
    },
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 7.5),
      decoration: BoxDecoration(
          gradient: data[widget.name]!["gradient"] as LinearGradient,
          borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 28, right: 16, bottom: 24, left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              width: 168,
              height: 122,
              data[widget.name]!["imagePath"] as String,
            ),
            SizedBox(
                width: 168,
                height: 22,
                child: Text(
                  data[widget.name]!["title"] as String,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Font.size_mediumText,
                    fontWeight: Font.weight_semiBold,
                  ),
                )),
            SizedBox(
                width: 168,
                height: 30,
                child: Text(
                  "${data[widget.name]!["des"] as String}\n",
                  style: TextStyle(
                    color: Coloring.gray_10,
                    fontSize: Font.size_smallText,
                    fontWeight: Font.weight_medium,
                  ),
                  maxLines: 2,
                )),
          ],
        ),
      ),
    );
  }
}
