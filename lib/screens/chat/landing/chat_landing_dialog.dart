import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/widgets/chat/dialog/chat_dialog_widget.dart';
import 'package:provider/provider.dart';

class ChatLandingDialog extends StatefulWidget {
  const ChatLandingDialog({Key? key}) : super(key: key);

  @override
  State<ChatLandingDialog> createState() => _ChatLandingDialogState();
}

class _ChatLandingDialogState extends State<ChatLandingDialog> {
  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();

    return
      GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView.builder(
            controller: scrollController,
            itemCount: context.watch<ChatProvider>().chats.length,
            itemBuilder: (BuildContext context, int index) {
              return ChatDialogWidget(
                  chat: context
                      .watch<ChatProvider>()
                      .getChatAt(index));
            }),
      );

  }
}

