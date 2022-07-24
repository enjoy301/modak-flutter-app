import 'package:flutter/material.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/screens/chat/landing/function/function_album_widget.dart';
import 'package:modak_flutter_app/screens/chat/landing/function/function_landing_widget.dart';
import 'package:modak_flutter_app/screens/chat/landing/function/function_onWay_widget.dart';
import 'package:provider/provider.dart';
import 'package:modak_flutter_app/constant/enum/chat_enum.dart';

class ChatLandingFunction extends StatefulWidget {
  const ChatLandingFunction({Key? key}) : super(key: key);

  @override
  State<ChatLandingFunction> createState() => _ChatLandingFunctionState();
}

class _ChatLandingFunctionState extends State<ChatLandingFunction> {
  final Map<FunctionState, Widget> functionStatePage = {
    FunctionState.landing: FunctionLandingWidget(),
    FunctionState.album: FunctionAlbumWidget(),
    FunctionState.onWay: FunctionOnWayWidget(),

  };

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, provider, child) {
      return Visibility(
          visible: provider.isFunctionOpened,
          child: SizedBox(
              height: 300,
              child: functionStatePage[provider.functionState] as Widget));
    });
  }
}
