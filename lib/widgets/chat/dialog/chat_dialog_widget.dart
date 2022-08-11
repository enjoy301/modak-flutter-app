import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/models/chat_model.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/widgets/chat/dialog/dialog_bubble_widget.dart';
import 'package:modak_flutter_app/widgets/chat/dialog/dialog_image_widget.dart';

class ChatDialogWidget extends StatefulWidget {
  const ChatDialogWidget({Key? key, required this.chat}) : super(key: key);
  final ChatModel chat;
  @override
  State<ChatDialogWidget> createState() => _ChatDialogWidgetState();
}

class _ChatDialogWidgetState extends State<ChatDialogWidget> {
  @override
  Widget build(BuildContext context) {
    final bool isMine = widget.chat.userId == UserProvider.user_id;
    return Container(
      margin: EdgeInsets.only(top: 9, right: 10, bottom: 8, left: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        textDirection: isMine ? ui.TextDirection.rtl : ui.TextDirection.ltr,
        children: [
          widget.chat.metaData!['type_code'] == 'plain'
              ? DialogBubbleWidget(chat: widget.chat)
              : DialogImageWidget(chat: widget.chat),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment:
                  isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.chat.readCount}',
                  style: TextStyle(
                    color: Coloring.info_yellow,
                    fontSize: Font.size_caption,
                    fontWeight: Font.weight_medium,
                  ),
                ),
                Text(
                  DateFormat("h:mm a")
                      .format(DateTime(widget.chat.sendAt.round()))
                      .toString(),
                  style: TextStyle(
                    color: Coloring.gray_20,
                    fontSize: Font.size_caption,
                    fontWeight: Font.weight_regular,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
