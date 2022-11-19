import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/data/dto/chat.dart';

class ChatComponentInfoWidget extends StatelessWidget {
  const ChatComponentInfoWidget({
    Key? key,
    required this.chat,
    this.showTime = true,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  }) : super(key: key);

  final Chat chat;
  final bool showTime;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(
            chat.unReadCount <= 0 ? "" : chat.unReadCount.toString(),
            style: TextStyle(
              color: Coloring.info_yellow,
              fontSize: Font.size_caption,
              fontWeight: Font.weight_medium,
            ),
          ),
          showTime
              ? Text(
                  DateFormat("h:mm a")
                      .format(
                        DateTime.fromMicrosecondsSinceEpoch(
                          (chat.sendAt * pow(10, 6).toInt()).round(),
                        ),
                      )
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
    );
  }
}
