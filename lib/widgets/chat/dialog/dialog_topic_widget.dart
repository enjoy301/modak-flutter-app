import 'package:flutter/material.dart';
import 'package:modak_flutter_app/data/dto/chat.dart';

class DialogTopicWidget extends StatelessWidget {
  const DialogTopicWidget({Key? key, required this.chat, required this.isMine})
      : super(key: key);

  final Chat chat;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
