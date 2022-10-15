import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/enum/chat_enum.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/ui/chat/landing/chat_dialog.dart';
import 'package:modak_flutter_app/ui/chat/landing/chat_header.dart';
import 'package:modak_flutter_app/ui/chat/landing/function/chat_landing_function.dart';
import 'package:modak_flutter_app/ui/chat/landing/input/chat_landing_input.dart';
import 'package:provider/provider.dart';

class ChatLandingScreen extends StatefulWidget {
  const ChatLandingScreen({Key? key}) : super(key: key);

  @override
  State<ChatLandingScreen> createState() => _ChatLandingScreenState();
}

class _ChatLandingScreenState extends State<ChatLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerBackWidget(context),
      backgroundColor: Colors.white,
      body: Consumer<ChatProvider>(
        builder: (context, provider, child) {
          return FutureBuilder(
            future: Future(() => provider.initial()),
            builder: (context, snapshot) {
              return SafeArea(
                child: Column(
                  children: [
                    Flexible(
                      child: ChatLandingDialog(),
                    ),
                    ChatLandingInput(),
                    ChatLandingFunction(),

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
                            provider.setFunctionState(FunctionState.landing);
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
  void deactivate() {
    super.deactivate();

    context.read<ChatProvider>().channel.sink.close();
  }
}
