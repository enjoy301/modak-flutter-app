import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/data/dto/chat.dart';

class ChatDateWidget extends StatelessWidget {
  const ChatDateWidget({Key? key, required this.chat}) : super(key: key);

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      decoration: BoxDecoration(
        color: Coloring.gray_40,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        DateFormat("yyyy-MM-dd")
            .format(
          DateTime.fromMillisecondsSinceEpoch(
            chat.sendAt.toInt() * 1000,
          ),
        )
            .toString(),
        style: TextStyle(
          color: Coloring.gray_10,
          fontSize: Font.size_largeText,
          fontWeight: Font.weight_regular,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}