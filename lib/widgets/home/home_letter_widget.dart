import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';

class HomeLetterWidget extends StatelessWidget {
  const HomeLetterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 18, left: 18),
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Coloring.bg_blue),
            padding: MaterialStateProperty.all(
              EdgeInsets.zero,
            ),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
          ),
          onPressed: () {
            Get.toNamed("/chat/letter/landing");
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "가족 대화",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: Font.size_smallText,
                      fontWeight: Font.weight_bold),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        "오늘의 편지가 \n도착했어요",
                        style: TextStyle(
                            color: Coloring.gray_0,
                            fontSize: Font.size_largeText,
                            fontWeight: Font.weight_bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Flexible(
                      child:
                          Image.asset("lib/assets/images/others/il_letter.png"),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      "편지함 가기 >",
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(color: Colors.grey[900]!.withOpacity(0.5)),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
