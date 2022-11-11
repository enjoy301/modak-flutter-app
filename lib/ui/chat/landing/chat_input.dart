import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:modak_flutter_app/assets/icons/dark/DarkIcons_icons.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/widgets/chat/chat_input_widget.dart';
import 'package:modak_flutter_app/widgets/icon/icon_gradient_widget.dart';
import 'package:provider/provider.dart';

import '../../../constant/enum/chat_enum.dart';

class InputChatWidget extends StatefulWidget {
  const InputChatWidget({Key? key}) : super(key: key);

  @override
  State<InputChatWidget> createState() => _InputChatWidget();
}

class _InputChatWidget extends State<InputChatWidget> {
  TextEditingController textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, provider, child) {
        return Container(
          color: Colors.white,
          child: Row(
            children: [
              /// row 1번 기능창 켜고 끄기 버튼
              IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();

                  Future.delayed(
                    Duration(milliseconds: 200),
                    () => {
                      provider.chatMode == ChatMode.textInput
                          ? provider.chatMode = ChatMode.functionList
                          : provider.chatMode = ChatMode.textInput
                    },
                  );
                },
                icon: Icon(
                  LightIcons.Plus,
                ),
              ),

              /// row 2번 채팅 입력 부분
              Expanded(
                  child: ChatInputWidget(
                textEditingController: textEditingController,
                focusNode: _focusNode,
                onTap: () {
                  provider.chatMode = ChatMode.textInput;
                },
                onChanged: (String input) {
                  provider.setCurrentInput(input);
                },
              )),

              /// row 3번 전송 or 하트 버튼
              provider.currentInput.trim() != ""
                  ? IconButton(
                      onPressed: () {
                        Map? metaData;
                        log(provider.feel);
                        if (provider.feelMode &&
                            provider.feel != Strings.none) {
                          metaData = {
                            "type_code": "feeling",
                            "feeling": provider.feel,
                          };
                          provider.feelMode = false;
                          provider.feel = Strings.none;
                        }
                        provider.postChat(
                          context,
                          textEditingController.value.text,
                          metaData: metaData,
                        );
                        provider.setCurrentInput("");

                        textEditingController.clear();
                      },
                      icon: IconGradientWidget(
                        DarkIcons.Send,
                        20,
                        Coloring.sub_purple,
                      ),
                    )
                  : (provider.chatMode == ChatMode.textInput)
                      ? IconButton(
                          icon: IconGradientWidget(
                            provider.feelMode
                                ? DarkIcons.Heart
                                : LightIcons.Heart,
                            20,
                            Coloring.sub_purple,
                          ),
                          onPressed: () {
                            provider.feelMode = !provider.feelMode;
                            if (provider.feelMode) _focusNode.requestFocus();
                          },
                        )
                      : SizedBox(
                          width: 48,
                          height: 48,
                        ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    textEditingController.text = context.read<ChatProvider>().currentInput;
  }
}
