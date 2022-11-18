import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/data/dto/chat.dart';
import 'package:modak_flutter_app/widgets/common/media_widget.dart';

class DialogLoadingWidget extends StatelessWidget {
  const DialogLoadingWidget({Key? key, required this.chat}) : super(key: key);

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
          child: MediaWidget(
            width: double.infinity,
            height: double.infinity,
            radius: 15,
            file: File(
              chat.content,
            ),
          ),
        ),
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
