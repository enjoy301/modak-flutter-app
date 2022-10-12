import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/data/model/chat.dart';
import 'package:modak_flutter_app/ui/user/user_family_modify_screen.dart';
import 'package:modak_flutter_app/widgets/chat/dialog/dialog_bubble_widget.dart';
import 'package:modak_flutter_app/widgets/chat/dialog/dialog_image_widget.dart';
import '../../../provider/user_provider.dart';
import 'package:provider/provider.dart';

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
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      return Column(
        children: [
          widget.isDateChanged
              ? Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  decoration: BoxDecoration(
                    color: Coloring.gray_40,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    DateFormat("yyyy-MM-dd")
                        .format(DateTime.fromMicrosecondsSinceEpoch(
                            (widget.chat.sendAt * pow(10, 6).toInt()).round()))
                        .toString(),
                    style: TextStyle(
                      color: Coloring.gray_10,
                      fontSize: Font.size_largeText,
                      fontWeight: Font.weight_regular,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              : SizedBox(),
          Container(
            margin: EdgeInsets.only(
                top: !widget.isHead ? 2 : 9,
                right: 10,
                bottom: !widget.isTail ? 2 : 8,
                left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              textDirection:
                  isMine ? ui.TextDirection.rtl : ui.TextDirection.ltr,
              children: [
                !isMine && widget.isHead
                    ? Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(UserFamilyModifyScreen(
                                familyMember: userProvider
                                    .findUserById(widget.chat.userId)!));
                          },
                          child: Image.asset(
                            "lib/assets/images/family/profile/dad_profile.png",
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
                (() {
                  if (widget.chat.metaData!['type_code'] == 'plain') {
                    return DialogBubbleWidget(
                      chat: widget.chat,
                      isMine: isMine,
                      isHead: widget.isHead,
                    );
                  } else if (widget.chat.metaData!['type_code'] == 'image') {
                    return DialogImageWidget(chat: widget.chat);
                  } else {
                    return Text("?");
                  }
                })(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: isMine
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chat.unReadCount <= 0
                            ? ""
                            : widget.chat.unReadCount.toString(),
                        style: TextStyle(
                          color: Coloring.info_yellow,
                          fontSize: Font.size_caption,
                          fontWeight: Font.weight_medium,
                        ),
                      ),
                      widget.isTail
                          ? Text(
                              DateFormat("h:mm a")
                                  .format(DateTime.fromMicrosecondsSinceEpoch(
                                      (widget.chat.sendAt * pow(10, 6).toInt())
                                          .round()))
                                  .toString(),
                              style: TextStyle(
                                color: Coloring.gray_20,
                                fontSize: Font.size_caption,
                                fontWeight: Font.weight_regular,
                              ),
                            )
                          : SizedBox()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
