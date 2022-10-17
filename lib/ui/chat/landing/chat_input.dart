import 'package:flutter/material.dart';
import 'package:modak_flutter_app/assets/icons/dark/DarkIcons_icons.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/widgets/icon/icon_gradient_widget.dart';
import 'package:provider/provider.dart';

import '../../../constant/enum/chat_enum.dart';

class InputChatWidget extends StatefulWidget {
  const InputChatWidget({Key? key}) : super(key: key);

  @override
  State<InputChatWidget> createState() => _InputChatWidgetState();
}

class _InputChatWidgetState extends State<InputChatWidget> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, provider, child) {
        return Row(
          children: [
            /// row 1번 기능창 켜고 끄기 버튼
            IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();

                Future.delayed(
                  Duration(milliseconds: 200),
                  () => {
                    provider.chatMode == ChatMode.textInput
                        ? provider.setChatMode(ChatMode.functionList)
                        : provider.setChatMode(ChatMode.textInput)
                  },
                );
              },
              icon: Icon(
                LightIcons.Plus,
                size: 20,
              ),
            ),

            /// row 2번 채팅 입력 부분
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 6),
                constraints: BoxConstraints(maxHeight: 100),
                child: TextField(
                  style: TextStyle(
                    fontSize: Font.size_largeText,
                    fontWeight: Font.weight_regular,
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: textEditingController,
                  onTap: () {
                    provider.setChatMode(ChatMode.textInput);
                  },
                  onChanged: (String input) {
                    provider.setCurrentInput(input);
                  },
                  decoration: InputDecoration(
                    hintText: "메시지를 입력하세요",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Coloring.gray_10),
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                ),
              ),
            ),

            /// row 3번 전송 or 하트 버튼
            provider.currentInput.trim() != ""
                ? IconButton(
                    onPressed: () {
                      provider.postPlainChat(
                        context,
                        textEditingController.value.text,
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
                : IconButton(
                    icon: IconGradientWidget(
                      DarkIcons.Heart,
                      20,
                      Coloring.sub_purple,
                    ),
                    onPressed: () {},
                  ),
          ],
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
