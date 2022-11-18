import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/data/dto/chat.dart';
import 'package:modak_flutter_app/utils/easy_style.dart';

import '../components/component_info_widget.dart';

class DialogTopicWidget extends StatefulWidget {
  const DialogTopicWidget(
      {Key? key,
      required this.chat,
      required this.isMine,
      required this.isTail})
      : super(key: key);

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
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Coloring.todo_orange,
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.chat.metaData!['title'],
                style: EasyStyle.text(Colors.orangeAccent[400]!,
                    Font.size_smallText, Font.weight_medium),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Coloring.gray_50,
                    borderRadius: BorderRadius.circular(15)),
                child: Text(widget.chat.content,
                    style: EasyStyle.text(Colors.black, Font.size_mediumText,
                        Font.weight_regular)),
              )
            ],
          ),
        ),
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
