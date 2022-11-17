import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/data/dto/chat.dart';

class DialogImageLoadingWidget extends StatelessWidget {
  const DialogImageLoadingWidget({Key? key, required this.chat})
      : super(key: key);

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width * 1 / 3,
              maxWidth: MediaQuery.of(context).size.width * 4 / 7,
              maxHeight: MediaQuery.of(context).size.width * 5 / 6,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.file(
                File(chat.content),
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                gaplessPlayback: true,
              ),
            )),
        Container(
          decoration: BoxDecoration(
            color: Coloring.gray_0.withOpacity(0.5),
            borderRadius: BorderRadius.circular(15),
          ),
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width * 1 / 3,
            maxWidth: MediaQuery.of(context).size.width * 4 / 7,
            maxHeight: MediaQuery.of(context).size.width * 5 / 6,
          ),
          child: SpinKitCircle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
