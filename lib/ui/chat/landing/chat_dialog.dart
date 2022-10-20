import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/enum/chat_enum.dart';
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
            provider.feelMode = false;
            provider.chatMode = ChatMode.textInput;
          },
          child: ListView.builder(
            controller: provider.scrollController,
            itemCount: provider.chats.length,
            reverse: true,
            itemBuilder: (BuildContext context, int index) {
              Chat chat = provider.chats[index];

              /// 마지막 인덱스임 || 먼저 보내진거랑 비교했을 때 다른거(index+1)
              bool isHead = index == provider.chats.length - 1
                  ? true
                  : isSameChat(
                        provider.chats[index],
                        provider.chats[index + 1],
                      ) ==
                      false;

              /// 첫 인덱스임 || 나중에 보내진거랑 다른거(index-1)
              bool isTail = index == 0
                  ? true
                  : isSameChat(
                        provider.chats[index - 1],
                        provider.chats[index],
                      ) ==
                      false;

              /// 마지막 인덱스임 || 먼저 보내진거랑 다른거(index+1
              bool isDateChanged = index == provider.chats.length - 1
                  ? true
                  : isSameDay(
                        provider.chats[index],
                        provider.chats[index + 1],
                      ) ==
                      false;

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

    context.read<ChatProvider>().addScrollListener(context);
  }
}

void scrollToEnd(BuildContext context) async {
  await Future.delayed(
    Duration(milliseconds: 100),
    () {
      if (context.read<ChatProvider>().isBottom == true) {
        ScrollController scrollController =
            context.read<ChatProvider>().scrollController;

        scrollController.animateTo(
          0,
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        );
        //
      }
    },
  );
}

String timestampToString(int timestamp) {
  return Date.getFormattedDate(
    format: "yyyy-MM-dd HH:mm",
    dateTime: DateTime.fromMillisecondsSinceEpoch(timestamp * 1000),
  );
}

bool isSameDay(Chat chat, Chat chat2) {
  return DateTime.fromMillisecondsSinceEpoch(
        chat.sendAt.toInt() * 1000,
      ).day ==
      DateTime.fromMillisecondsSinceEpoch(
        chat2.sendAt.toInt() * 1000,
      ).day;
}

bool isSameMinute(Chat chat, Chat chat2) {
  return timestampToString(chat.sendAt.toInt()) ==
      timestampToString(chat2.sendAt.toInt());
}

bool isSameUser(Chat chat, Chat chat2) {
  return chat.userId == chat2.userId;
}

bool isSameChat(Chat chat, Chat chat2) {
  return isSameMinute(chat, chat2) && isSameUser(chat, chat2);
}
