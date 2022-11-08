import 'dart:math';

import 'package:flutter/material.dart';
import 'package:modak_flutter_app/assets/icons/dark/DarkIcons_icons.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/chat_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
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
        height: 200,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "아 오늘 따라",
              style: TextStyle(color: Colors.black, fontSize: Font.size_largeText, fontWeight: Font.weight_regular),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                  },
                  icon: Icon(
                    LightIcons.CloseSquare,
                    size: 20,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    constraints: BoxConstraints(maxHeight: 100),
                    child: TextField(
                      autofocus: true,
                      style: TextStyle(
                        fontSize: Font.size_largeText,
                        fontWeight: Font.weight_regular,
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: _textEditingController,
                      onChanged: (String input) {
                        setState(() {
                          text = input;
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 14),
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
                IconButton(
                  onPressed: () {
                    chatProvider.postChat(context, text, metaData: {
                      'type_code': "onway",
                      'step': Random().nextInt(10),
                    });
                    chatProvider.chatMode = ChatMode.textInput;
                    text = "";
                    setState(() {});
                  },
                  icon: IconGradientWidget(
                    _textEditingController.text.isEmpty ? LightIcons.Send : DarkIcons.Send,
                    20,
                    Coloring.sub_purple,
                  ),
                )
              ],
            ),
            Text(
              "먹고 싶은데.. 누가 사다 줬으면",
              style: TextStyle(color: Colors.black, fontSize: Font.size_largeText, fontWeight: Font.weight_regular),
            ),
          ],
        ),
      );
    });
  }
}
