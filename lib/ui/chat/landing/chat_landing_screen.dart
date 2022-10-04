import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/enum/chat_enum.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/ui/chat/landing/chat_landing_dialog.dart';
import 'package:modak_flutter_app/ui/chat/landing/function/chat_landing_function.dart';
import 'package:modak_flutter_app/ui/chat/landing/chat_landing_header.dart';
import 'package:modak_flutter_app/ui/chat/landing/input/chat_landing_input.dart';
import 'package:provider/provider.dart';

class ChatLandingScreen extends StatefulWidget {
  const ChatLandingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatLandingScreen> createState() => _ChatLandingScreenState();
}

class _ChatLandingScreenState extends State<ChatLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerBackWidget(context),
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: Future(() => context.read<ChatProvider>().initial(context)),
          builder: (context, snapshot) {
            return SafeArea(
              child: Column(
                children: [
                  Flexible(child: ChatLandingDialog()),
                  // ChatLandingEmotion(),
                  ChatLandingInput(),
                  ChatLandingFunction(),
                  Consumer<ChatProvider>(
                    builder: (context, provider, child) {
                      return Visibility(
                        visible: false,
                        maintainState: true,
                        child: WillPopScope(
                          child: Text(""),
                          onWillPop: () {
                            /// Function State 가 landing 이 아닐 때
                            if ([
                              FunctionState.album,
                              FunctionState.onWay,
                              FunctionState.todo
                            ].contains(provider.functionState)) {
                              provider.setFunctionState(FunctionState.landing);
                              return Future(() => false);
                            }

                            /// Function 메뉴가 열려있을 때
                            if (provider.isFunctionOpened) {
                              provider.isFunctionOpenedToggle();
                              return Future(() => false);
                            }
                            provider.refresh();
                            return Future(() => true);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }),
    );
  }

  @override
  void deactivate() {
    super.deactivate();

    context.read<ChatProvider>().channel.sink.close();
  }
}
