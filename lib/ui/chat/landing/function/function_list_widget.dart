import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/chat_enum.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/utils/media_util.dart';
import 'package:modak_flutter_app/widgets/chat/chat_function_icon_widget.dart';
import 'package:modak_flutter_app/widgets/modal/default_modal_widget.dart';
import 'package:provider/provider.dart';

class FunctionListWidget extends StatefulWidget {
  const FunctionListWidget({Key? key}) : super(key: key);

  @override
  State<FunctionListWidget> createState() => _FunctionListWidget();
}

class _FunctionListWidget extends State<FunctionListWidget> {
  final List<Map<String, dynamic>> functionIconWidgetValues = [
    {
      'name': "앨범",
      'icon': LightIcons.Image,
      'color': Coloring.bg_pink,
    },
    {
      'name': "카메라",
      'icon': LightIcons.Camera,
      'color': Coloring.bg_red,
    },
    {
      'name': "오는 길에",
      'icon': LightIcons.Work,
      'color': Coloring.bg_orange,
    },
    {
      'name': "룰렛",
      'icon': LightIcons.TicketStar,
      'color': Coloring.bg_yellow,
    },
    {
      'name': "편지",
      'icon': LightIcons.Calendar,
      'color': Coloring.point_pureorange
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, provider, build) {
        return SizedBox(
          height: 300,
          child: GridView(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.8,
              crossAxisCount: 4,
            ),
            children: [
              ChatFunctionIconWidget(
                data: functionIconWidgetValues[0],
                onTap: () async {
                  provider.setChatMode(ChatMode.functionAlbum);
                  if (provider.mediaFiles.isEmpty) {
                    List<File> files = await getImageFromAlbum();
                    for (File file in files) {
                      await provider.addMedia(file);
                    }
                  }
                },
              ),
              ChatFunctionIconWidget(
                data: functionIconWidgetValues[1],
                onTap: () async {
                  defaultModalWidget(
                    context,
                    [
                      TextButton(
                          onPressed: () async {
                            Future(() => Navigator.pop(context));

                            dio.MultipartFile? image =
                                await getImageFromCamera();
                            // provider.postMediaFilesFromCamera(image, "png", 1);
                          },
                          child: Text("사진 찍기")),
                      TextButton(
                          onPressed: () async {
                            Future(() => Navigator.pop(context));
                            dio.MultipartFile? video =
                                await getVideoFromCamera();
                            // provider.postMediaFilesFromCamera(video, "mp4", 0);
                          },
                          child: Text("동영상 촬영"))
                    ],
                  );
                },
              ),
              ChatFunctionIconWidget(
                data: functionIconWidgetValues[2],
                onTap: () {
                  log("오는 길에~");
                  // provider.setFunctionState(FunctionState.onWay);
                },
              ),
              ChatFunctionIconWidget(
                data: functionIconWidgetValues[3],
                onTap: () {
                  log("룰렛 돌리기~");
                },
              ),
              ChatFunctionIconWidget(
                data: functionIconWidgetValues[4],
                onTap: () {
                  Get.toNamed("/chat/letter/landing");
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
