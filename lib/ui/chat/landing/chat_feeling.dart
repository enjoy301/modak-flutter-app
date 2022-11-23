import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/widgets/common/scalable_text_widget.dart';
import 'package:provider/provider.dart';

class ChatFeeling extends StatelessWidget {
  const ChatFeeling({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, chatProvider, child) {
      return Container(
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: GestureDetector(
                  onTap: () {
                    chatProvider.feelMode = false;
                  },
                  child: Image.asset(
                    "lib/assets/functional_image/ic_close.png",
                    width: 32,
                    height: 32,
                  ),
                ),
              ),
              ...[Strings.love, Strings.congrats, Strings.sorry]
                  .mapIndexed(
                    (int index, String feeling) => GestureDetector(
                      onTap: () {
                        if (chatProvider.feel == feeling) {
                          chatProvider.feel = Strings.none;
                        } else {
                          chatProvider.feel = feeling;
                        }
                      },
                      child: ChatFeelingItem(
                        feelingType: feeling,
                        showFeeling: feeling == chatProvider.feel,
                      ),
                    ),
                  )
                  .toList()
            ],
          ),
        ),
      );
    });
  }
}

class ChatFeelingItem extends StatelessWidget {
  ChatFeelingItem(
      {Key? key, required this.feelingType, this.showFeeling = true})
      : super(key: key);

  final bool showFeeling;
  final String feelingType;

  final feelingsMap = {
    Strings.love: {
      "title": "사랑해요",
      "color": Coloring.bg_red,
      "icon": "ic_love",
      "pat": "pat_love",
    },
    Strings.congrats: {
      "title": "축하해요",
      "color": Coloring.bg_purple,
      "icon": "ic_congrats",
      "pat": "pat_congrats",
    },
    Strings.sorry: {
      "title": "미안해요",
      "color": Coloring.bg_blue,
      "icon": "ic_sorry",
      "pat": "pat_sorry",
    },
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: showFeeling
                  ? DecorationImage(
                      image: AssetImage(
                        "lib/assets/images/chat/feeling/${feelingsMap[feelingType]!['pat']}.png",
                      ),
                      repeat: ImageRepeat.repeat,
                      fit: BoxFit.contain)
                  : null,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: showFeeling
                    ? feelingsMap[feelingType]!['color'] as Color
                    : Coloring.gray_50,
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
                  ScalableTextWidget(
                      feelingsMap[feelingType]!['title'] as String,
                      style: TextStyle(fontSize: Font.size_mediumText)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
