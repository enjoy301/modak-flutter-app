import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';

class ChatBubbleWidget extends StatefulWidget {
  const ChatBubbleWidget(
      {Key? key, required this.direction, required this.contents})
      : super(key: key);
  final DirectionType direction;
  final String contents;
  @override
  State<ChatBubbleWidget> createState() => _ChatBubbleWidgetState();
}

class _ChatBubbleWidgetState extends State<ChatBubbleWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.direction == DirectionType.right
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        InkWell(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              constraints: BoxConstraints(minWidth: 30, maxWidth: 300),
              decoration: BoxDecoration(
                color: Colors.pinkAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  widget.contents,
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
          ),
        )
      ],
    );

  }
}
