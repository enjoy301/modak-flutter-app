import 'dart:math';

import 'package:flutter/material.dart';
import 'package:modak_flutter_app/assets/icons/dark/DarkIcons_icons.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/chat_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/utils/easy_style.dart';
import 'package:modak_flutter_app/widgets/chat/chat_input_widget.dart';
import 'package:modak_flutter_app/widgets/common/scalable_text_widget.dart';
import 'package:modak_flutter_app/widgets/icon/icon_gradient_widget.dart';
import 'package:provider/provider.dart';

class FunctionOnWayWidget extends StatefulWidget {
  const FunctionOnWayWidget({Key? key}) : super(key: key);

  @override
  State<FunctionOnWayWidget> createState() => _FunctionOnWayWidget();
}

class _FunctionOnWayWidget extends State<FunctionOnWayWidget> {
  final TextEditingController _textEditingController = TextEditingController();
  String text = "";

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, chatProvider, child) {
      return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                Future.delayed(
                  Duration(milliseconds: 200),
                  () => chatProvider.chatMode = ChatMode.functionList,
                );
              },
              icon: Icon(
                LightIcons.CloseSquare,
              ),
            ),
            ScalableTextWidget(
              "오늘",
              style: EasyStyle.text(
                  Coloring.gray_10, Font.size_mediumText, Font.weight_regular),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ChatInputWidget(
                  textEditingController: _textEditingController,
                  hint: "치킨",
                  autofocus: true,
                  textAlign: TextAlign.center,
                  onChanged: (String input) {
                    setState(() {
                      text = input;
                    });
                  },
                ),
              ),
            ),
            ScalableTextWidget(
              "어때요?",
              style: EasyStyle.text(
                  Coloring.gray_10, Font.size_mediumText, Font.weight_regular),
            ),
            IconButton(
              onPressed: () {
                if (text.trim().isNotEmpty) {
                  chatProvider.postChat(context, text, metaData: {
                    'type_code': "onway",
                    'step': Random().nextInt(10),
                  });
                  chatProvider.chatMode = ChatMode.textInput;
                  text = "";
                  setState(() {});
                }
              },
              icon: IconGradientWidget(
                _textEditingController.text.isEmpty
                    ? LightIcons.Send
                    : DarkIcons.Send,
                20,
                Coloring.sub_purple,
              ),
            )
          ],
        ),
      );
    });
  }
}
