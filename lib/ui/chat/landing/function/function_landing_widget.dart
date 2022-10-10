import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/chat_enum.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/services/chat_service.dart';
import 'package:modak_flutter_app/utils/media_util.dart';
import 'package:modak_flutter_app/widgets/chat/chat_function_icon_widget.dart';
import 'package:modak_flutter_app/widgets/modal/default_modal_widget.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

class FunctionLandingWidget extends StatefulWidget {
  const FunctionLandingWidget({Key? key}) : super(key: key);

  @override
  State<FunctionLandingWidget> createState() => _FunctionLandingWidgetState();
}

class _FunctionLandingWidgetState extends State<FunctionLandingWidget> {
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
    {'name': "룰렛", 'icon': LightIcons.TicketStar, 'color': Coloring.bg_yellow},
    {'name': "위치 공유", 'icon': LightIcons.Location, 'color': Coloring.bg_purple},
    {
      'name': "편지 보내기",
      'icon': LightIcons.Calendar,
      'color': Coloring.point_pureorange
    },
    {'name': "할 일 공유", 'icon': LightIcons.Plus, 'color': Coloring.gray_30},
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, provider, build) {
        return GridView(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

              /// TODO 화면 비율에 따라 짤리지 않도록 변경
              childAspectRatio: 0.8,
              crossAxisCount: 4),
          children: [
            ChatFunctionIconWidget(
              data: functionIconWidgetValues[0],
              onTap: () async {
                provider.setFunctionState(FunctionState.album);
                if (provider.medias.isEmpty) {
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
                defaultModalWidget(context, [
                  TextButton(
                      onPressed: () async {
                        Future(() => Navigator.pop(context));

                        dio.MultipartFile? image = await getImageFromCamera();

                        Map<String, dynamic> response =
                            await sendMedia(image, "png", 1);

                        if (response['result'] != "FAIL") {
                          print(response['response']);
                        } else {
                          print(response['message']);
                        }
                      },
                      child: Text("사진 찍기")),
                  TextButton(
                      onPressed: () async {
                        Future(() => Navigator.pop(context));
                        dio.MultipartFile? video = await getVideoFromCamera();
                        Map<String, dynamic> response =
                            await sendMedia(video, "mp4", 0);
                        if (response['result'] != "FAIL") {
                          print(response['response']);
                        } else {
                          print(response['message']);
                        }
                      },
                      child: Text("동영상 촬영"))
                ]);
              },
            ),
            ChatFunctionIconWidget(
              data: functionIconWidgetValues[2],
              onTap: () {
                provider.setFunctionState(FunctionState.onWay);
              },
            ),
            ChatFunctionIconWidget(
              data: functionIconWidgetValues[3],
              onTap: () {
                print(4);
              },
            ),
            ChatFunctionIconWidget(
              data: functionIconWidgetValues[4],
              onTap: () {
                print(5);
              },
            ),
            ChatFunctionIconWidget(
              data: functionIconWidgetValues[5],
              onTap: () {
                Get.toNamed("/chat/letter/landing");
              },
            ),
            ChatFunctionIconWidget(
              data: functionIconWidgetValues[6],
              onTap: () {
                print(7);
              },
            ),
          ],
        );
      },
    );
  }
}
