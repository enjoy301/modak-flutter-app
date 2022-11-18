import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/dto/chat.dart';
import 'package:modak_flutter_app/widgets/chat/components/component_info_widget.dart';
import 'package:modak_flutter_app/widgets/common/scalable_text_widget.dart';
import 'package:modak_flutter_app/widgets/modal/list_modal_widget.dart';
import 'package:vibration/vibration.dart';

class DialogFeelingsWidget extends StatelessWidget {
  DialogFeelingsWidget(
      {Key? key,
      required this.chat,
      required this.isMine,
      required this.isHead,
      required this.isTail})
      : super(key: key);

  final Chat chat;
  final bool isMine;
  final bool isHead;
  final bool isTail;

  final feelingsMap = {
    Strings.love: {
      "color": Coloring.bg_red,
      "icon": "ic_love",
      "pat": "pat_love",
    },
    Strings.congrats: {
      "color": Coloring.bg_purple,
      "icon": "ic_congrats",
      "pat": "pat_congrats",
    },
    Strings.sorry: {
      "color": Coloring.bg_blue,
      "icon": "ic_sorry",
      "pat": "pat_sorry",
    },
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: isMine ? TextDirection.rtl : TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          // onLongPress: () {
          //   Vibration.vibrate(duration: 10, amplitude: 140);
          //   listModalWidget(context, {
          //     "클립보드 복사": () {
          //       Clipboard.setData(ClipboardData(text: chat.content));
          //       Fluttertoast.showToast(msg: "클립보드에 복사되었습니다");
          //       Get.back();
          //     },
          //     "집안일 등록": () {
          //       Get.back();
          //     },
          //     "룰렛 돌리기": () {
          //       Get.back();
          //     },
          //   });
          // },
          child: Container(
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
                            "lib/assets/images/chat/feeling/${feelingsMap[chat.metaData!['feeling']]!['pat']}.png",
                          ),
                          repeat: ImageRepeat.repeat,
                          fit: BoxFit.scaleDown)),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: feelingsMap[chat.metaData!['feeling']]!['color']
                          as Color,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Image.asset(
                            "lib/assets/images/chat/feeling/${feelingsMap[chat.metaData!['feeling']]!['icon']}.png",
                            width: 20,
                            height: 20,
                          ),
                        ),
                        Flexible(
                          child: ScalableTextWidget(chat.content,
                              style: TextStyle(
                                  color: Coloring.gray_10,
                                  fontSize: Font.size_mediumText,
                                  fontWeight: Font.weight_medium),
                              maxLines: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ChatComponentInfoWidget(
          chat: chat,
          crossAxisAlignment:
              isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          showTime: isTail,
        ),
      ],
    );
  }
}
