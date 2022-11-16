import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/enum/chat_enum.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/ui/chat/landing/function/function_album_widget.dart';
import 'package:modak_flutter_app/ui/chat/landing/function/function_list_widget.dart';
import 'package:modak_flutter_app/ui/chat/landing/function/function_onway_widget.dart';
import 'package:modak_flutter_app/ui/chat/landing/function/function_todo_widget.dart';
import 'package:provider/provider.dart';

class ChatFunction extends StatefulWidget {
  const ChatFunction({Key? key}) : super(key: key);

  @override
  State<ChatFunction> createState() => _ChatFunction();
}

class _ChatFunction extends State<ChatFunction> {
  final Map<ChatMode, Widget> functionStatePage = {
    ChatMode.textInput: SizedBox.shrink(),
    ChatMode.functionTodo: FunctionTodoWidget(),
    ChatMode.functionList: FunctionListWidget(),
    ChatMode.functionAlbum: FunctionAlbumWidget(),
    ChatMode.functionOnway: FunctionOnWayWidget(),
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, provider, child) {
        return Container(
          color: Colors.transparent,
          child: functionStatePage[provider.chatMode] as Widget,
        );
      },
    );
  }
}
