import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:modak_flutter_app/constant/enum/chat_enum.dart';
import 'package:modak_flutter_app/models/chat_model.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/screens/chat/landing/chat_landing_dialog.dart';
import 'package:modak_flutter_app/screens/chat/landing/chat_landing_emotion.dart';
import 'package:modak_flutter_app/screens/chat/landing/function/chat_landing_function.dart';
import 'package:modak_flutter_app/screens/chat/landing/chat_landing_header.dart';
import 'package:modak_flutter_app/screens/chat/landing/input/chat_landing_input.dart';
import 'package:modak_flutter_app/services/chat_service.dart';
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
  @override
  Widget build(BuildContext context) {
    IOWebSocketChannel.connect(
            "${dotenv.get("CHAT_WSS")}/dev?u=${UserProvider.user_id}&f=${UserProvider.family_id}")
        .stream
        .listen((event) {
      var item = jsonDecode(event) as Map;

      if (item.containsKey("message_data")) {
        var message = item['message_data'];
        int readCount = context.read<ChatProvider>().getNowJoin();
        context.read<ChatProvider>().addChat(ChatModel(
              userId: message['user_id'],
              content: message['content'],
              sendAt: message['send_at'],
              metaData: message['metadata'],
              readCount: readCount,
            ));
      } else if (item.containsKey("connection_data")) {
        var connection = item['connection_data'];
        context.read<ChatProvider>().setConnection(connection);
      }
    });
    return Scaffold(
      appBar: headerBackWidget(context),
      body: SafeArea(
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
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setConnections(context);
    getChats(context);
  }
}
