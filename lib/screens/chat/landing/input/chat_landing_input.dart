import 'package:flutter/material.dart';
import 'package:modak_flutter_app/models/chat_model.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/services/chat_service.dart';
import 'package:provider/provider.dart';

class ChatLandingInput extends StatefulWidget {
  const ChatLandingInput({Key? key}) : super(key: key);

  @override
  State<ChatLandingInput> createState() => _ChatLandingInputState();
}

class _ChatLandingInputState extends State<ChatLandingInput> {
  TextEditingController textEditingController = TextEditingController();
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              setState(() =>
                  {context.read<ChatProvider>().isFunctionOpenedToggle()});
              FocusScope.of(context).unfocus();
              print(context.read<ChatProvider>().isFunctionOpened);
            },
            icon: Icon(Icons.add)),
        Expanded(
            child: TextField(
          controller: textEditingController,
          onTap: () {
            setState(() =>
                {context.read<ChatProvider>().setIsFunctionOpened(false)});
          },
          onChanged: (String chat) {
            context.read<ChatProvider>().setCurrentMyChat(chat);
          },
          decoration: InputDecoration(
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
          ),
        )),
        IconButton(
          onPressed: () {
            context.read<ChatProvider>().add(ChatModel(
                userId: UserProvider.user_id,
                content: textEditingController.value.text,
                sendAt: DateTime.now().millisecondsSinceEpoch.toDouble(),
                typeCode: "plain",
                metaData: null));
            sendChat(context, textEditingController.value.text, "plain");
            context.read<ChatProvider>().setCurrentMyChat("");
            textEditingController.clear();
          },
          icon: Icon(Icons.send),
        ),
      ],
    );
  }

  @override
  void initState() {
    getChats(context);
    textEditingController.text = context.read<ChatProvider>().currentMyChat;
  }
}
