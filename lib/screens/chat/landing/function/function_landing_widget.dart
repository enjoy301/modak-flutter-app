import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modak_flutter_app/constant/enum/chat_enum.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/services/chat_service.dart';
import 'package:modak_flutter_app/utils/camera_util.dart';
import 'package:modak_flutter_app/widgets/chat/chat_function_icon_widget.dart';
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
      'image': "lib/assets/img.png",
      'color': Colors.red,
    },
    {
      'name': "카메라",
      'image': "lib/assets/img.png",
      'color': Colors.red,
    },
    {
      'name': "오는 길에",
      'image': "lib/assets/img.png",
      'color': Colors.red,
    },
    {'name': "룰렛", 'image': "lib/assets/img.png", 'color': Colors.red},
    {'name': "위치 공유", 'image': "lib/assets/img.png", 'color': Colors.blue},
    {'name': "일정 추가", 'image': "lib/assets/img.png", 'color': Colors.red},
    {'name': "할 일 공유", 'image': "lib/assets/img.png", 'color': Colors.red},
  ];
  @override
  Widget build(BuildContext context) {

    return Consumer<ChatProvider>(
      builder: (context, provider, build) {
        return GridView(

          shrinkWrap: true,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 100),
          children: [
            ChatFunctionIconWidget(
              data: functionIconWidgetValues[0],
              onTap: () async {
                XFile? response = await getImageFromCamera();
                if (response != null) {
                  var formData = MultipartFile.fromFileSync(response.path, contentType: MediaType("image", "jpg"));
                  var formData2 = FormData.fromMap({"image": formData});

                  sendMedia(formData2);
                }
              },
            ),
            ChatFunctionIconWidget(
              data: functionIconWidgetValues[1],
              onTap: () async {
                provider.setFunctionState(FunctionState.album);
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
                print(6);
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
      }
    );
  }
}
