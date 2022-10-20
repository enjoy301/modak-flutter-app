import 'dart:async';

import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/enum/chat_enum.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/ui/chat/landing/chat_dialog.dart';
import 'package:modak_flutter_app/ui/chat/landing/chat_header.dart';
import 'package:modak_flutter_app/ui/chat/landing/chat_input.dart';
import 'package:modak_flutter_app/ui/chat/landing/function/chat_function.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreen> {
  late Future initial;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: chatHeader(context),
      backgroundColor: Colors.white,
      body: Consumer<ChatProvider>(
        builder: (context, provider, child) {
          return FutureBuilder(
            future: initial,
            builder: (context, snapshot) {
              return SafeArea(
                child: Column(
                  children: [
                    Flexible(
                      child: ChatDialog(),
                    ),
                    [ChatMode.textInput, ChatMode.functionList]
                            .contains(provider.chatMode)
                        ? InputChatWidget()
                        : SizedBox.shrink(),
                    ChatFunction(),

                    /// this widget for 뒤로가기 시 반응
                    Visibility(
                      visible: false,
                      maintainState: true,
                      child: WillPopScope(
                        child: SizedBox.shrink(),
                        onWillPop: () {
                          if (provider.chatMode == ChatMode.functionList) {
                            provider.setChatMode(ChatMode.textInput);
                            return Future(() => false);
                          } else if (provider.chatMode ==
                              ChatMode.functionAlbum) {
                            provider.setChatMode(ChatMode.functionList);
                            return Future(() => false);
                          }

                          provider.refresh();
                          return Future(() => true);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    initial = context.read<ChatProvider>().initial(context);
  }

  @override
  void deactivate() {
    super.deactivate();

    context.read<ChatProvider>().channel.sink.close();
  }
}
