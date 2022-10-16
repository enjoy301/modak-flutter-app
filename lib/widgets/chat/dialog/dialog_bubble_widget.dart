import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/data/dto/chat.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/widgets/modal/default_modal_widget.dart';
import 'package:provider/provider.dart';

class DialogBubbleWidget extends StatefulWidget {
  const DialogBubbleWidget(
      {Key? key, required this.chat, required this.isMine, this.isHead = true})
      : super(key: key);

  final Chat chat;
  final bool isMine;
  final bool isHead;

  @override
  State<DialogBubbleWidget> createState() => _DialogBubbleWidgetState();
}

class _DialogBubbleWidgetState extends State<DialogBubbleWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      onTapCancel: () {},
      onLongPress: () {
        defaultModalWidget(context, [
          TextButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: widget.chat.content));
                Fluttertoast.showToast(msg: "클립보드에 복사되었습니다");
                Get.back();
              },
              child: Text("클립보드 복사")),
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("집안일 등록")),
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("룰렛 돌리기")),
        ]);
      },
      child: Column(
        children: [
          !widget.isMine && widget.isHead
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    "${context.read<UserProvider>().findUserById(widget.chat.userId)?.name}",
                    textAlign: TextAlign.left,
                  ),
                )
              : SizedBox.shrink(),
          Row(
            children: [
              /// row children 1번 상대 메세지 꼬리
              !widget.isMine && widget.isHead
                  ? Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationX(pi),
                      child: CustomPaint(
                        painter: CustomShape(Coloring.bg_orange, "receive"),
                      ),
                    )
                  : SizedBox(),

              /// row children 2번 글자 네모 박스
              Container(
                constraints: BoxConstraints(minWidth: 30, maxWidth: 250),
                decoration: BoxDecoration(
                  color: widget.isMine
                      ? Coloring.point_pureorange
                      : Coloring.bg_orange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 9, right: 10, bottom: 8, left: 10),
                  child: Text(
                    widget.chat.content,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Font.size_mediumText,
                      fontWeight: Font.weight_regular,
                    ),
                  ),
                ),
              ),

              /// row children 3번 내 메세지 꼬리
              widget.isMine && widget.isHead
                  ? Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationX(pi),
                      child: CustomPaint(
                        painter: CustomShape(Coloring.point_pureorange, "send"),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomShape extends CustomPainter {
  final Color bgColor;
  final String type;
  CustomShape(this.bgColor, this.type);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = bgColor;

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
