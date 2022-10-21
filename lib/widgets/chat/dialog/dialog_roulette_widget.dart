import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/data/dto/chat.dart';
import 'package:modak_flutter_app/data/dto/user.dart';
import 'package:modak_flutter_app/ui/chat/roulette/chat_roulette_result_screen.dart';
import 'package:modak_flutter_app/widgets/chat/components/component_info_widget.dart';
import 'package:modak_flutter_app/widgets/common/scalable_text_widget.dart';

class DialogRouletteWidget extends StatefulWidget {
  const DialogRouletteWidget(
      {Key? key,
      required this.chat,
      required this.isMine,
      this.isHead = true,
      this.isTail = true})
      : super(key: key);

  final Chat chat;
  final bool isMine;
  final bool isHead;
  final bool isTail;

  @override
  State<DialogRouletteWidget> createState() => _DialogRouletteWidgetState();
}

class _DialogRouletteWidgetState extends State<DialogRouletteWidget> {
  double height = 10;
  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: widget.isMine ? TextDirection.rtl : TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        /// row children 1번 글자 네모 박스
        TextButton(
          onPressed: () {
            Get.to(ChatRouletteResultScreen(
                title: "설거지 하기",
                addTodo: true,
                participatedUsers: [
                  User(
                      memberId: -1,
                      name: "test",
                      birthDay: "",
                      isLunar: false,
                      role: "DAD",
                      fcmToken: "fcmToken",
                      color: "#FffF0000",
                      timeTags: []),
                  User(
                      memberId: -1,
                      name: "test",
                      birthDay: "",
                      isLunar: false,
                      role: "DAD",
                      fcmToken: "fcmToken",
                      color: "#FF0000FF",
                      timeTags: []),
                ],
                selectedUser: User(
                    memberId: -1,
                    name: "test",
                    birthDay: "",
                    isLunar: false,
                    role: "DAD",
                    fcmToken: "fcmToken",
                    color: "#FffF0000",
                    timeTags: [])));
          },
          style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              overlayColor: MaterialStateProperty.all(Colors.transparent)),
          child: Container(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width * 0.6,
              maxWidth: MediaQuery.of(context).size.width * 0.6,
            ),
            decoration: BoxDecoration(
                color: Coloring.bg_red,
                borderRadius: BorderRadius.circular(20),
                border:
                    Border.all(color: Colors.black.withOpacity(0.3), width: 4)),
            child: Padding(
              padding: EdgeInsets.only(top: 15, right: 15, bottom: 6, left: 15),
              child: Column(
                children: [
                  ScalableTextWidget(
                    widget.chat.content,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Font.size_subTitle,
                      fontWeight: Font.weight_semiBold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "룰렛 결과가 도착했습니다",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Font.size_mediumText,
                      fontWeight: Font.weight_medium,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 30),
                    child: Image.asset(
                      "lib/assets/images/others/il_roulette.png",
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                  ),
                  Text(
                    "내 결과를 확인하세요",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Font.size_mediumText,
                        fontWeight: Font.weight_regular),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Coloring.gray_50),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      child: Text(
                        "결과 확인",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Font.size_mediumText,
                            fontWeight: Font.weight_regular),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),

        /// row children 3번 시간과 읽은 수 표시
        ChatComponentInfoWidget(
          chat: widget.chat,
          crossAxisAlignment:
              widget.isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          showTime: widget.isTail,
        ),
      ],
    );
  }
}
