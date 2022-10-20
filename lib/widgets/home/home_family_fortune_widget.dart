import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/home_provider.dart';
import 'package:provider/provider.dart';

class HomeFamilyFortuneWidget extends StatefulWidget {
  const HomeFamilyFortuneWidget({Key? key}) : super(key: key);

  @override
  State<HomeFamilyFortuneWidget> createState() =>
      _HomeFamilyFortuneWidgetState();
}

class _HomeFamilyFortuneWidgetState extends State<HomeFamilyFortuneWidget> {
  int idx = 100;
  void animation() async {
    for (int i = 0; i < 10; i++) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        idx += 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
      return Padding(
        padding: const EdgeInsets.only(top: 20, right: 18, left: 18),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            padding: MaterialStateProperty.all(
              EdgeInsets.zero,
            ),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
          ),
          onPressed: () async {
            if (homeProvider.todayFortune == null) {
              await homeProvider.getTodayFortune();
              setState(() {
                idx = 0;
              });
              animation();
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "대화 주제",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: Font.size_smallText,
                      fontWeight: Font.weight_bold),
                ),
                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8, right: 8, bottom: 8),
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Coloring.bg_yellow,
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              "lib/assets/images/others/il_monkey.png",
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "꾸몽이 오늘의 한 마디 해줄게",
                            style: TextStyle(
                              color: Coloring.gray_20,
                              fontSize: Font.size_mediumText,
                              fontWeight: Font.weight_regular,
                            ),
                          ),
                          Text(
                            "오늘의 한 마디는...",
                            style: TextStyle(
                                color: Coloring.gray_0,
                                fontSize: Font.size_subTitle,
                                fontWeight: Font.weight_semiBold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                  margin: EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                      color: Colors.brown[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    "클릭 해서 오늘의 한 마디를 확인해 봐",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                if (homeProvider.todayFortune != null)
                  FamilyFortuneChatsWidget(
                    homeProvider: homeProvider,
                    idx: idx,
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class FamilyFortuneChatsWidget extends StatefulWidget {
  const FamilyFortuneChatsWidget(
      {Key? key, required this.homeProvider, required this.idx})
      : super(key: key);

  final HomeProvider homeProvider;
  final int idx;

  @override
  State<FamilyFortuneChatsWidget> createState() =>
      _FamilyFortuneChatsWidgetState();
}

class _FamilyFortuneChatsWidgetState extends State<FamilyFortuneChatsWidget> {
  final Map<String, Map<String, String>> typeMap = {
    "운세": {
      "first": "오늘은 운세에 대해서 알려줄게",
      "second": "오늘의 운세는...",
      "third": "오호~ 그렇구만\n오늘도 행운만 가득하기를"
    },
    "마음의 소리": {
      "first": "오늘은 너의 마음 속에 있는 생각을 맞춰 볼게",
      "second": "너는 지금 어떤 생각을 하고 있을까",
      "third": "오호~ 그렇구만\n오늘도 행운만 가득하기를"
    },
    "명언": {
      "first": "오늘은 가족과 관련된 명언 하나를 알려줄게",
      "second": "오늘의 가족 명언은...",
      "third": "가족은 인생에 아주 중요한 역할을 하는 것 같아. 소중함을 잊지 않기를!"
    },
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.idx > 0)
          FamilyFortuneChatWidget(
              text: typeMap[widget.homeProvider.todayFortune?.type]
                      ?["first"]! ??
                  ""),
        if (widget.idx > 1)
          FamilyFortuneChatWidget(
              text: typeMap[widget.homeProvider.todayFortune?.type]
                      ?["second"]! ??
                  ""),
        if (widget.idx > 2)
          FamilyFortuneChatWidget(
              text: widget.homeProvider.todayFortune!.content),
        if (widget.idx > 3)
          FamilyFortuneChatWidget(
              text: typeMap[widget.homeProvider.todayFortune?.type]
                      ?["third"]! ??
                  ""),
      ],
    );
  }
}

class FamilyFortuneChatWidget extends StatelessWidget {
  const FamilyFortuneChatWidget({Key? key, required this.text})
      : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
          color: Colors.brown[100], borderRadius: BorderRadius.circular(12)),
      child: Text(
        text,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
