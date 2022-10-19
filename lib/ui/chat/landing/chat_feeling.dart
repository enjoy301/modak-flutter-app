import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:provider/provider.dart';

class ChatFeeling extends StatefulWidget {
  const ChatFeeling({Key? key}) : super(key: key);

  @override
  State<ChatFeeling> createState() => _ChatFeelingState();
}

class _ChatFeelingState extends State<ChatFeeling> {
  int selected = -1;

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
              ...FeelingType.values
                  .mapIndexed(
                    (int index, FeelingType feeling) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = index;
                        });
                      },
                      child: ChatFeelingItem(
                        feelingType: feeling,
                        showFeeling: index == selected,
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
  final FeelingType feelingType;

  final feelingsMap = {
    FeelingType.love: {
      "title": "사랑해요",
      "color": Coloring.bg_red,
      "icon": "ic_love",
      "pat": "pat_love",
    },
    FeelingType.congrats: {
      "title": "축하해요",
      "color": Coloring.bg_purple,
      "icon": "ic_congrats",
      "pat": "pat_congrats",
    },
    FeelingType.sorry: {
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
                  Text(feelingsMap[feelingType]!['title'] as String),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
