import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/data/dto/chat.dart';
import 'package:modak_flutter_app/utils/easy_style.dart';
import 'package:word_break_text/word_break_text.dart';

import '../components/component_info_widget.dart';

class DialogTopicWidget extends StatefulWidget {
  const DialogTopicWidget({
    Key? key,
    required this.chat,
    required this.isMine,
    required this.isTail,
  }) : super(key: key);

  final Chat chat;
  final bool isMine;
  final bool isTail;

  @override
  State<DialogTopicWidget> createState() => _DialogTopicWidgetState();
}

class _DialogTopicWidgetState extends State<DialogTopicWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      textDirection: widget.isMine ? TextDirection.rtl : TextDirection.ltr,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          padding: EdgeInsets.symmetric(vertical: 13, horizontal: 13),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Coloring.todo_orange,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                " ${widget.chat.metaData!['title']}",
                style: EasyStyle.text(Colors.orangeAccent[400]!, Font.size_smallText, Font.weight_medium),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Coloring.gray_50,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: WordBreakText(
                  widget.chat.content,
                  style: EasyStyle.text(
                    Colors.black,
                    Font.size_mediumText,
                    Font.weight_regular,
                  ),
                  textAlign: TextAlign.center,
                  wrapAlignment: WrapAlignment.center,
                ),
              )
            ],
          ),
        ),
        ChatComponentInfoWidget(
          chat: widget.chat,
          crossAxisAlignment: widget.isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          showTime: widget.isTail,
        ),
      ],
    );
  }
}
