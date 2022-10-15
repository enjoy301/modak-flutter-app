import 'package:flutter/material.dart';
import 'package:modak_flutter_app/assets/icons/dark/DarkIcons_icons.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/widgets/icon/icon_gradient_widget.dart';
import 'package:provider/provider.dart';

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
            IconButton(
              onPressed: () {
                provider.isFunctionOpenedToggle();
                FocusScope.of(context).unfocus();
              },
              icon: Icon(
                LightIcons.Plus,
                size: 20,
              ),
            ),
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
                    provider.setIsFunctionOpened(false);
                  },
                  onChanged: (String chat) {
                    provider.setCurrentMyChat(chat);
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
            provider.currentMyChat.trim() != ""
                ? IconButton(
                    onPressed: () {
                      provider.postChat(
                        context,
                        textEditingController.value.text,
                      );
                      provider.setCurrentMyChat("");

                      textEditingController.clear();
                    },
                    icon: IconGradientWidget(
                      DarkIcons.Send,
                      20,
                      Coloring.sub_purple,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      provider.toggleIsEmotionOpened();
                    },
                    icon: provider.isEmotionOpened
                        ? IconGradientWidget(
                            DarkIcons.Heart,
                            20,
                            Coloring.sub_purple,
                          )
                        : Icon(
                            LightIcons.Heart,
                            size: 20,
                          ),
                  ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    textEditingController.text = context.read<ChatProvider>().currentMyChat;
  }
}
