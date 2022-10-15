import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/enum/chat_enum.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/ui/chat/landing/function/function_album_widget.dart';
import 'package:modak_flutter_app/ui/chat/landing/function/function_list_widget.dart';
import 'package:modak_flutter_app/ui/chat/landing/function/function_onway_widget.dart';
import 'package:provider/provider.dart';

class ChatFunction extends StatefulWidget {
  const ChatFunction({Key? key}) : super(key: key);

  @override
  State<ChatFunction> createState() => _ChatFunction();
}

class _ChatFunction extends State<ChatFunction> {
  final Map<FunctionState, Widget> functionStatePage = {
    FunctionState.list: FunctionListWidget(),
    FunctionState.album: FunctionAlbumWidget(),
    FunctionState.onWay: FunctionOnWayWidget(),
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, provider, child) {
        return Container(
          color: Colors.white,
          child: Visibility(
            visible: provider.isFunctionOpened,
            child: functionStatePage[provider.functionState] as Widget,
          ),
        );
      },
    );
  }
}
