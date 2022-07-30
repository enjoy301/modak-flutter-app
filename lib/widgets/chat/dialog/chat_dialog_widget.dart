import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/models/chat_model.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';

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
        mainAxisAlignment:
            isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "1",
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
          Container(
            constraints: BoxConstraints(minWidth: 30, maxWidth: 250),
            decoration: BoxDecoration(
              color: isMine ? Coloring.point_pureorange : Coloring.bg_orange,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 9, right: 10, bottom: 8, left: 10),
              child: Text(
                widget.chat.content,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Font.size_mediumText,
                  fontWeight: Font.weight_regular,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

