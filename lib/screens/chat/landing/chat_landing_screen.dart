import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:modak_flutter_app/constant/enum/chat_enum.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/screens/chat/landing/chat_landing_dialog.dart';
import 'package:modak_flutter_app/screens/chat/landing/function/chat_landing_function.dart';
import 'package:modak_flutter_app/screens/chat/landing/chat_landing_header.dart';
import 'package:modak_flutter_app/screens/chat/landing/input/chat_landing_input.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';

class ChatLandingScreen extends StatefulWidget {
  const ChatLandingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatLandingScreen> createState() => _ChatLandingScreenState();
}

class _ChatLandingScreenState extends State<ChatLandingScreen> {
  var channel = IOWebSocketChannel.connect("${dotenv.get("CHAT_WSS")}/dev?u=2")
      .stream
      .listen((event) {
    print(event);
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: headerBackWidget(context),
        body: Column(
          children: [
            Flexible(child: ChatLandingDialog()),
            ChatLandingInput(),
            ChatLandingFunction(),
            Consumer<ChatProvider>(builder: (context, provider, child) {
              return WillPopScope(
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
                  });
            }),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {}
}
