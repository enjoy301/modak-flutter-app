import 'dart:math';

import 'package:flutter/material.dart';
import 'package:modak_flutter_app/data/dto/chat.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/utils/date.dart';
import 'package:modak_flutter_app/widgets/chat/dialog/chat_dialog_widget.dart';
import 'package:provider/provider.dart';

class ChatDialog extends StatefulWidget {
  const ChatDialog({Key? key}) : super(key: key);

  @override
  State<ChatDialog> createState() => _ChatDialog();
}

class _ChatDialog extends State<ChatDialog> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollToEnd(context));
    return Consumer<ChatProvider>(
      builder: (context, provider, child) {
        return GestureDetector(
          onTap: () {
            /// for 키보드 dispose
            FocusScope.of(context).unfocus();
          },
          child: ListView.builder(
            controller: provider.scrollController,
            itemCount: provider.chats.length,
            itemBuilder: (BuildContext context, int index) {
              Chat chat = provider.chats[index];
              bool isHead = true;
              bool isTail = true;
              bool isDateChanged = true;

              if (index > 0) {
                isDateChanged =
                    !compareChatByDay(chat, provider.chats[index - 1]);
              }
              if (index > 0 && compareChat(chat, provider.chats[index - 1])) {
                isHead = false;
              }
              if (index < provider.chats.length - 1 &&
                  compareChat(chat, provider.chats[index + 1])) {
                isTail = false;
              }
              return ChatDialogWidget(
                chat: chat,
                isHead: isHead,
                isTail: isTail,
                isDateChanged: isDateChanged,
              );
            },
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    context.read<ChatProvider>().addScrollListener();
  }

  @override
  void dispose() {
    super.dispose();

    context.read<ChatProvider>().scrollController.dispose();
  }
}

void scrollToEnd(BuildContext context) {
  if (context.read<ChatProvider>().isBottom == true) {
    ScrollController scrollController =
        context.read<ChatProvider>().scrollController;
    scrollController.jumpTo(
      scrollController.position.maxScrollExtent,
    );
  }
}

String getChatDateString(Chat chat) {
  String chatTime = Date.getFormattedDate(
      format: "yyyy-MM-dd HH:mm",
      dateTime: DateTime.fromMicrosecondsSinceEpoch(
          chat.sendAt.toInt() * pow(10, 6).toInt()));
  return chatTime;
}

bool compareChatByMinute(Chat chat, Chat chat2) {
  String chatTime = getChatDateString(chat);
  String chatTime2 = getChatDateString(chat2);
  return chatTime == chatTime2;
}

bool compareChatByDay(Chat chat, Chat chat2) {
  return DateTime.fromMicrosecondsSinceEpoch(
              chat.sendAt.toInt() * pow(10, 6).toInt())
          .day ==
      DateTime.fromMicrosecondsSinceEpoch(
              chat2.sendAt.toInt() * pow(10, 6).toInt())
          .day;
}

bool compareChatByUser(Chat chat, Chat chat2) {
  int userId = chat.userId;
  int userId2 = chat2.userId;
  return userId == userId2;
}

bool compareChat(Chat chat, Chat chat2) {
  return compareChatByMinute(chat, chat2) && compareChatByUser(chat, chat2);
}
