import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/enum/chat_enum.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
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
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          children: [
            ChatFunctionIconWidget(
              data: functionIconWidgetValues[0],
              onTap: () async {
                final response = await getImageFromCamera();
                print(response);
              },
            ),
            ChatFunctionIconWidget(
              data: functionIconWidgetValues[1],
              onTap: () async {
                provider.setFunctionState(FunctionState.album);
              },
            ),
            ChatFunctionIconWidget(
              data: functionIconWidgetValues[1],
              onTap: () {
                provider.setFunctionState(FunctionState.onWay);
              },
            ),
            ChatFunctionIconWidget(
              data: functionIconWidgetValues[1],
              onTap: () {
                print(4);
              },
            ),
            ChatFunctionIconWidget(
              data: functionIconWidgetValues[1],
              onTap: () {
                print(5);
              },
            ),
            ChatFunctionIconWidget(
              data: functionIconWidgetValues[1],
              onTap: () {
                print(6);
              },
            ),
            ChatFunctionIconWidget(
              data: functionIconWidgetValues[1],
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
