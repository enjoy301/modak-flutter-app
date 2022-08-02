import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:modak_flutter_app/assets/icons/dark/DarkIcons_icons.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/chat_enum.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/services/chat_service.dart';
import 'package:modak_flutter_app/utils/media_util.dart';
import 'package:modak_flutter_app/widgets/icon/icon_gradient_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class InputFunctionWidget extends StatefulWidget {
  const InputFunctionWidget({Key? key}) : super(key: key);

  @override
  State<InputFunctionWidget> createState() => _InputFunctionWidgetState();
}

class _InputFunctionWidgetState extends State<InputFunctionWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, provider, child) {
      return Row(
        children: [
          IconButton(
              onPressed: () {
                context
                    .read<ChatProvider>()
                    .setFunctionState(FunctionState.landing);
              },
              icon: Icon(Icons.cancel_sharp)),
          Expanded(child: Center(child: Text("보내고 싶은 사진 혹은 영상을 선택하세요"))),
          IconButton(
              onPressed: () async {
                if (provider.selectedMedias.isNotEmpty) {
                  MultipartFile zipFile = await compressFilesToZip(provider.selectedMedias);
                  Map<String, dynamic> response = await sendMedia(zipFile, "zip");
                  print(response['result']);

                  provider.clearSelectedMedia();
                  provider.setIsFunctionOpened(false);
                  provider.setFunctionState(FunctionState.landing);
                }
              },
              icon: IconGradientWidget(
                provider.selectedMedias.isEmpty
                    ? LightIcons.Send
                    : DarkIcons.Send,
                25,
                Coloring.sub_purple,
              ))
        ],
      );
    });
  }
}
