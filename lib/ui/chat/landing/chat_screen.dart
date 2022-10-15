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
  // var keyboardVisibilityController = KeyboardVisibilityController();
  // late StreamSubscription<bool> keyboardSubscription;

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
                    provider.getInputState() == InputState.chat
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
                          /// 앨범, 오는길에 일 때 뒤로가기를 누르면 채팅 입력으로 바뀜
                          if ([
                            FunctionState.album,
                            FunctionState.onWay,
                            FunctionState.todo,
                          ].contains(provider.functionState)) {
                            provider.setFunctionState(FunctionState.list);
                            return Future(() => false);
                          }

                          /// Function 메뉴가 열려있을 때 뒤로가기를 누르면 function 메뉴가 꺼짐
                          if (provider.isFunctionOpened) {
                            provider.isFunctionOpenedToggle();
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

    initial = context.read<ChatProvider>().initial();

    // keyboardSubscription =
    //     keyboardVisibilityController.onChange.listen((bool visible) {
    //   if (visible) {
    //     print("wiwiwiwiw");
    //     if (context.read<ChatProvider>().isBottom == true) {
    //       print("${context.read<ChatProvider>().isBottom}");
    //       ScrollController scrollController =
    //           context.read<ChatProvider>().scrollController;
    //       scrollController.jumpTo(
    //         scrollController.position.maxScrollExtent,
    //       );
    //     }
    //   }
    // });
  }

  @override
  void deactivate() {
    super.deactivate();

    // keyboardSubscription.cancel();
    context.read<ChatProvider>().channel.sink.close();
  }
}
