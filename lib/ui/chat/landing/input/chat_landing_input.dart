import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/enum/chat_enum.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/ui/chat/landing/input/input_chat_widget.dart';
import 'package:modak_flutter_app/ui/chat/landing/input/input_function_widget.dart';
import 'package:provider/provider.dart';

class ChatLandingInput extends StatefulWidget {
  const ChatLandingInput({Key? key}) : super(key: key);

  @override
  State<ChatLandingInput> createState() => _ChatLandingInputState();
}

class _ChatLandingInputState extends State<ChatLandingInput> {
  final Map<InputState, Widget> inputStatePage = {
    InputState.none: Text(""),
    InputState.chat: InputChatWidget(),
    InputState.function: InputFunctionWidget(),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: inputStatePage[context.watch<ChatProvider>().getInputState()]
          as Widget,
    );
  }
}
