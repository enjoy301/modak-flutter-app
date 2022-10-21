import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/data/dto/chat.dart';
import 'package:modak_flutter_app/ui/user/user_family_modify_screen.dart';
import 'package:modak_flutter_app/widgets/chat/chat_date_widget.dart';
import 'package:modak_flutter_app/widgets/chat/dialog/dialog_bubble_widget.dart';
import 'package:modak_flutter_app/widgets/chat/dialog/dialog_feelings_widget.dart';
import 'package:modak_flutter_app/widgets/chat/dialog/dialog_image_widget.dart';
import 'package:modak_flutter_app/widgets/chat/dialog/dialog_roulette_widget.dart';
import 'package:modak_flutter_app/widgets/common/scalable_text_widget.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';
import 'dialog_video_widget.dart';

class ChatDialogWidget extends StatefulWidget {
  const ChatDialogWidget({
    Key? key,
    required this.chat,
    this.isHead = true,
    this.isTail = true,
    this.isDateChanged = false,
  }) : super(key: key);
  final Chat chat;
  final bool isHead;
  final bool isTail;
  final bool isDateChanged;
  @override
  State<ChatDialogWidget> createState() => _ChatDialogWidgetState();
}

class _ChatDialogWidgetState extends State<ChatDialogWidget> {
  @override
  Widget build(BuildContext context) {
    final bool isMine =
        widget.chat.userId == context.read<UserProvider>().me!.memberId;
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return Column(
          children: [
            /// column children 1번 날짜 변경선
            if (widget.isDateChanged) ChatDateWidget(chat: widget.chat),

            /// column children 2번 채팅 한 bubble 전체
            Container(
              margin: EdgeInsets.only(
                  top: !widget.isHead ? 2 : 9,
                  right: 10,
                  bottom: !widget.isTail ? 2 : 8,
                  left: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection:
                    isMine ? ui.TextDirection.rtl : ui.TextDirection.ltr,
                children: [
                  /// row children 1번 프로필
                  !isMine && widget.isHead
                      ? Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(
                                UserFamilyModifyScreen(
                                  familyMember: userProvider
                                      .findUserById(widget.chat.userId)!,
                                ),
                              );
                            },
                            child: Image.asset(
                              "lib/assets/images/family/profile/${context.read<UserProvider>().findUserById(widget.chat.userId)?.role.toLowerCase()}_profile.png",
                              width: 40,
                              height: 40,
                            ),
                          ),
                        )
                      : isMine
                          ? SizedBox()
                          : SizedBox(
                              width: 50,
                              height: 40,
                            ),

                  /// row children 2번 채팅 글 or 사진
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      !isMine && widget.isHead
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: ScalableTextWidget(
                                "${context.read<UserProvider>().findUserById(widget.chat.userId)?.name}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Coloring.gray_10,
                                    fontSize: Font.size_caption),
                              ),
                            )
                          : SizedBox.shrink(),
                      (() {
                        switch (widget.chat.metaData!['type_code']) {
                          case "plain":
                            return DialogBubbleWidget(
                              chat: widget.chat,
                              isMine: isMine,
                              isHead: widget.isHead,
                              isTail: widget.isTail,
                            );
                          case "feelings":
                            return DialogFeelingsWidget(chat: widget.chat);
                          case "image":
                            return DialogImageWidget(
                              chat: widget.chat,
                              isMine: isMine,
                            );
                          case "video":
                            return DialogVideoWidget(
                              chat: widget.chat,
                              isMine: isMine,
                            );
                          case "roulette":
                            return DialogRouletteWidget(
                              chat: widget.chat,
                              isMine: isMine,
                              isHead: widget.isHead,
                              isTail: widget.isTail,
                            );
                          default:
                            return SizedBox.shrink();
                        }
                      })(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
