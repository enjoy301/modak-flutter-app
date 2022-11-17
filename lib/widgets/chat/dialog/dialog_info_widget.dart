import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/data/dto/chat.dart';

class DialogInfoWidget extends StatelessWidget {
  const DialogInfoWidget({Key? key, required this.chat}) : super(key: key);

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        chat.content,
        style: TextStyle(
          color: Coloring.gray_10,
          fontSize: Font.size_caption,
          fontWeight: Font.weight_medium,
        ),
        textAlign: TextAlign.center,
      ),
    );
    ;
  }
}
