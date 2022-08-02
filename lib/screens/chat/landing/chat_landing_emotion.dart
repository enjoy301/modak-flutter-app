import 'package:flutter/material.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:provider/provider.dart';

class ChatLandingEmotion extends StatefulWidget {
  const ChatLandingEmotion({Key? key}) : super(key: key);

  @override
  State<ChatLandingEmotion> createState() => _ChatLandingEmotionState();
}

class _ChatLandingEmotionState extends State<ChatLandingEmotion> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, provider, child) {
      return Visibility(visible: provider.isEmotionOpened, child: Text("임시"));
    });
  }
}
