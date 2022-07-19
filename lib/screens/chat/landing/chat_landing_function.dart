import 'package:flutter/material.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/widgets/chat/chat_function_icon_widget.dart';
import 'package:provider/provider.dart';

class ChatLandingFunction extends StatefulWidget {
  const ChatLandingFunction({Key? key}) : super(key: key);

  @override
  State<ChatLandingFunction> createState() => _ChatLandingFunctionState();
}

class _ChatLandingFunctionState extends State<ChatLandingFunction> {

  final List<Map<String, dynamic>> functionIconWidgetValues = [
    {'name': "앨범", 'image': "lib/assets/img.png", 'color': Colors.red,},
    {'name': "카메라", 'image': "lib/assets/img.png", 'color': Colors.red,},
    {'name': "오는 길에", 'image': "lib/assets/img.png", 'color': Colors.red,},
    {'name': "룰렛", 'image': "lib/assets/img.png", 'color': Colors.red},
    {'name': "위치 공유", 'image': "lib/assets/img.png", 'color': Colors.blue},
    {'name': "일정 추가", 'image': "lib/assets/img.png", 'color': Colors.red},
    {'name': "할 일 공유", 'image': "lib/assets/img.png", 'color': Colors.red},
  ];

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: context.watch<ChatProvider>().isFunctionOpened,
        child: GridView(
          shrinkWrap: true,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          children: [
            ChatFunctionIconWidget(data: functionIconWidgetValues[0]),
            ChatFunctionIconWidget(data: functionIconWidgetValues[1]),
            ChatFunctionIconWidget(data: functionIconWidgetValues[2]),
            ChatFunctionIconWidget(data: functionIconWidgetValues[3]),
            ChatFunctionIconWidget(data: functionIconWidgetValues[4]),
            ChatFunctionIconWidget(data: functionIconWidgetValues[5]),
            ChatFunctionIconWidget(data: functionIconWidgetValues[6]),
          ],
        ));
  }
}
