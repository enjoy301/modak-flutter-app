import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/chat_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/data/dto/chat.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/ui/chat/roulette/chat_roulette_landing_screen.dart';
import 'package:modak_flutter_app/widgets/chat/components/component_info_widget.dart';
import 'package:modak_flutter_app/widgets/common/pressed_timer_widget.dart';
import 'package:modak_flutter_app/widgets/common/scalable_text_widget.dart';
import 'package:modak_flutter_app/widgets/modal/theme_position_list_widget.dart';
import 'package:provider/provider.dart';

class DialogBubbleWidget extends StatefulWidget {
  const DialogBubbleWidget(
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
  State<DialogBubbleWidget> createState() => _DialogBubbleWidgetState();
}

class _DialogBubbleWidgetState extends State<DialogBubbleWidget> {
  final GlobalKey _key = GlobalKey();
  double height = 10;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => getSizeAndPosition(),
    );
  }

  getSizeAndPosition() {
    RenderBox box = _key.currentContext?.findRenderObject() as RenderBox;
    Size size = box.size;
    height = size.height;
    setState(() {});
  }

  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, chatProvider, child) {
      return PressedTimerWidget(
        duration: Duration(milliseconds: 400),
        onTimePressed: (TapDownDetails details) {
          HapticFeedback.lightImpact();
          FocusScope.of(context).unfocus();
          themePositionListWidget(context, details: details, itemList: [
            {
              'name': '클립보드 복사',
              'icon': Icon(
                LightIcons.Document,
                color: Coloring.gray_0,
              ),
              'onTap': () {
                Clipboard.setData(ClipboardData(text: widget.chat.content));
                Fluttertoast.showToast(msg: "클립보드에 복사되었습니다");
                Get.back();
              }
            },
            {
              'name': '집안일 등록',
              'icon': Icon(
                LightIcons.Plus,
                color: Coloring.gray_0,
              ),
              'onTap': () {
                Get.back();
                chatProvider.chatMode = ChatMode.functionTodo;
                chatProvider.todoTitle = widget.chat.content;
              }
            },
            {
              'name': '룰렛 돌리기',
              'icon': Icon(
                LightIcons.Game,
                color: Coloring.gray_0,
              ),
              'onTap': () {
                Get.back();
                Get.to(ChatRouletteLandingScreen(
                  title: widget.chat.content,
                ));
              }
            },
          ]);
          setState(() {
            isPressed = false;
          });
        },
        onStateChanged: (bool state) {
          setState(() {
            isPressed = state;
          });
        },
        child: Row(
          textDirection: widget.isMine ? TextDirection.rtl : TextDirection.ltr,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            /// row children 1번 메세지 꼬리
            if (widget.isHead)
              Padding(
                padding: EdgeInsets.only(bottom: height - 10),
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationX(pi),
                  child: CustomPaint(
                    painter: CustomShape(
                        widget.isMine ? "send" : "receive", isPressed),
                  ),
                ),
              ),

            /// row children 2번 글자 네모 박스
            Container(
              key: _key,
              constraints: BoxConstraints(
                minWidth: 30,
                maxWidth: MediaQuery.of(context).size.width * 0.6,
              ),
              decoration: BoxDecoration(
                color: widget.isMine
                    ? isPressed
                        ? Coloring.point_pureorange.withOpacity(0.7)
                        : Coloring.bg_orange
                    : isPressed
                        ? Coloring.gray_40
                        : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding:
                    EdgeInsets.only(top: 9, right: 10, bottom: 8, left: 10),
                child: ScalableTextWidget(
                  widget.chat.content,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Font.size_mediumText,
                    fontWeight: Font.weight_regular,
                  ),
                ),
              ),
            ),

            /// row children 3번 시간과 읽은 수 표시
            ChatComponentInfoWidget(
              chat: widget.chat,
              crossAxisAlignment: widget.isMine
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              showTime: widget.isTail,
            ),
          ],
        ),
      );
    });
  }
}

class CustomShape extends CustomPainter {
  final String type;
  final bool isPressed;
  CustomShape(this.type, this.isPressed);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = type == "send"
          ? isPressed
              ? Coloring.point_pureorange
              : Coloring.bg_orange
          : isPressed
              ? Coloring.gray_40
              : Colors.white;

    var path = Path();
    path.lineTo(5, 0);
    path.lineTo(type == "send" ? -2 : 2, -10);
    path.lineTo(-5, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
