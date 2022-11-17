import 'dart:async';

import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/chat_enum.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/ui/chat/landing/chat_dialog.dart';
import 'package:modak_flutter_app/ui/chat/landing/chat_feeling.dart';
import 'package:modak_flutter_app/ui/chat/landing/chat_input.dart';
import 'package:modak_flutter_app/ui/chat/landing/function/chat_function.dart';
import 'package:modak_flutter_app/widgets/common/colored_safe_area.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
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
    return ColoredSafeArea(
      color: Colors.white,
      child: Scaffold(
        appBar: headerDefaultWidget(title: "우리 가족 채팅방"),
        backgroundColor: Coloring.gray_50,
        body: Consumer<ChatProvider>(
          builder: (context, provider, child) {
            return FutureBuilder(
              future: initial,
              builder: (context, snapshot) {
                return SafeArea(
                  child: Column(
                    children: [
                      if (snapshot.connectionState == ConnectionState.done) ...[
                        Flexible(
                          child: ChatDialog(),
                        ),
                      ] else ...[
                        Flexible(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],

                      if (provider.feelMode) ChatFeeling(),
                      [
                        ChatMode.textInput,
                        ChatMode.functionList,
                      ].contains(provider.chatMode)
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
                            if (provider.feelMode) {
                              provider.feelMode = false;
                              return Future(() => false);
                            }
                            if (provider.chatMode == ChatMode.functionList) {
                              provider.chatMode = ChatMode.textInput;
                              return Future(() => false);
                            } else if (provider.chatMode == ChatMode.functionAlbum) {
                              provider.chatMode = ChatMode.functionList;
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
                // else {
                //
                // }
              },
            );
          },
        ),
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
