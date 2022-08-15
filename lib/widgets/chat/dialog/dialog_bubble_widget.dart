import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/models/chat_model.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/utils/prefs_util.dart';

class DialogBubbleWidget extends StatefulWidget {
  const DialogBubbleWidget({Key? key, required this.chat}) : super(key: key);

  final ChatModel chat;
  @override
  State<DialogBubbleWidget> createState() => _DialogBubbleWidgetState();
}

class _DialogBubbleWidgetState extends State<DialogBubbleWidget> {

  @override
  Widget build(BuildContext context) {
    final bool isMine = widget.chat.userId == PrefsUtil.getInt("user_id");

    return Container(
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
    );
  }
}
