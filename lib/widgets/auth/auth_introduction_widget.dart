import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/constant/shadowing.dart';

class AuthIntroductionWidget extends StatefulWidget {
  const AuthIntroductionWidget({Key? key, required this.name}) : super(key: key);

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
      "title": "앨범",
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
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.only(top: 50, right: 0, bottom: 72, left: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "${data[widget.name]!["title"] as String}\n",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Font.size_h1,
                  fontWeight: Font.weight_bold,
                ),
                maxLines: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "${data[widget.name]!["des"] as String}\n",
                style: TextStyle(
                  color: Coloring.gray_10,
                  fontSize: Font.size_largeText,
                  fontWeight: Font.weight_medium,
                ),
                maxLines: 2,
              ),
            ),
            Expanded(child: SizedBox.shrink()),
            Image.asset(
              data[widget.name]!["imagePath"] as String,
            ),
          ],
        ),
      ),
    );
  }
}
