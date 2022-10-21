import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/data/dto/chat.dart';

class DialogFeelingsWidget extends StatelessWidget {
  DialogFeelingsWidget({Key? key, required this.chat}) : super(key: key);

  final Chat chat;
  final FeelingType? feelingType = FeelingType.love;

  final feelingsMap = {
    FeelingType.love: {
      "color": Coloring.bg_red,
      "icon": "ic_love",
      "pat": "pat_love",
    },
    FeelingType.congrats: {
      "color": Coloring.bg_purple,
      "icon": "ic_congrats",
      "pat": "pat_congrats",
    },
    FeelingType.sorry: {
      "color": Coloring.bg_blue,
      "icon": "ic_sorry",
      "pat": "pat_sorry",
    },
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: 30,
        maxWidth: MediaQuery.of(context).size.width * 0.6,
      ),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                    image: AssetImage(
                      "lib/assets/images/chat/feeling/${feelingsMap[feelingType]!['pat']}.png",
                    ),
                    repeat: ImageRepeat.repeat,
                    fit: BoxFit.contain)),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: feelingsMap[feelingType]!['color'] as Color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Image.asset(
                      "lib/assets/images/chat/feeling/${feelingsMap[feelingType]!['icon']}.png",
                      width: 20,
                      height: 20,
                    ),
                  ),
                  // Text(chat.content, style: TextS,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
