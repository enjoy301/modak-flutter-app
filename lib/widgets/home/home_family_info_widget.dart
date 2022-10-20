import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/ui/common/common_web_screen.dart';

class HomeFamilyInfoWidget extends StatefulWidget {
  const HomeFamilyInfoWidget(
      {Key? key,
      required this.type,
      required this.title,
      required this.contents,
      required this.link})
      : super(key: key);

  final HomePostType type;
  final String title;
  final String contents;
  final String link;

  @override
  State<HomeFamilyInfoWidget> createState() => _HomeFamilyInfoWidgetState();
}

class _HomeFamilyInfoWidgetState extends State<HomeFamilyInfoWidget> {
  final Map<HomePostType, dynamic> typeMap = {
    HomePostType.travel: {
      "typeText": "여행",
      "image": "lib/assets/images/others/il_travel.png",
      "backgroundColor": Coloring.bg_green,
    },
    HomePostType.cook: {
      "typeText": "요리",
      "image": "lib/assets/images/others/il_cook.png",
      "backgroundColor": Coloring.bg_orange,
    }
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 18, left: 18),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              typeMap[widget.type]["backgroundColor"]),
          padding: MaterialStateProperty.all(
            EdgeInsets.zero,
          ),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        ),
        onPressed: () {
          Get.to(CommonWebScreen(title: widget.title, link: widget.link));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                typeMap[widget.type]["typeText"],
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: Font.size_smallText,
                    fontWeight: Font.weight_bold),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                widget.title,
                style: TextStyle(
                  color: Coloring.gray_0,
                  fontSize: Font.size_largeText,
                  fontWeight: Font.weight_medium,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Image.asset(
                      typeMap[widget.type]["image"],
                      width: 120,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      widget.contents,
                      style: TextStyle(
                          color: Coloring.gray_0,
                          fontSize: Font.size_mediumText,
                          fontWeight: Font.weight_bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    "정보 보러 가기 >",
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.grey[900]!.withOpacity(0.5)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
