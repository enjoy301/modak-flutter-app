import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/data/dto/chat.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/widgets/chat/components/component_info_widget.dart';
import 'package:provider/provider.dart';

class DialogOnwayWidget extends StatefulWidget {
  const DialogOnwayWidget({Key? key, required this.chat, required this.isMine, required this.isTail}) : super(key: key);

  final Chat chat;
  final bool isMine;
  final bool isTail;

  @override
  State<DialogOnwayWidget> createState() => _DialogOnwayWidgetState();
}

class _DialogOnwayWidgetState extends State<DialogOnwayWidget> {
  late List<Widget> screens;
  @override
  void initState() {
    screens = [
      DialogOnwayFirstWidget(chat: widget.chat),
      DialogOnwaySecondWidget(chat: widget.chat),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: widget.isMine ? TextDirection.rtl : TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
            width: MediaQuery.of(context).size.width * 0.6,
            padding: EdgeInsets.only(top: 15, right: 15, bottom: 12, left: 15),
            decoration: BoxDecoration(
              color: Coloring.bg_orange,
              borderRadius: BorderRadius.circular(20),
            ),
            child: screens[(widget.chat.metaData!['step'] / 10).floor()]),
        ChatComponentInfoWidget(
          chat: widget.chat,
          crossAxisAlignment: widget.isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          showTime: widget.isTail,
        ),
      ],
    );
  }
}

class DialogOnwayFirstWidget extends StatefulWidget {
  const DialogOnwayFirstWidget({Key? key, required this.chat}) : super(key: key);

  final Chat chat;

  @override
  State<DialogOnwayFirstWidget> createState() => _DialogOnwayFirstWidgetState();
}

class _DialogOnwayFirstWidgetState extends State<DialogOnwayFirstWidget> {
  final dynamic sentences = [
    ["0", "example"],
    ["1", "example"],
    ["2", "example"],
    ["3", "example"],
    ["4", "example"],
    ["5", "example"],
    ["6", "example"],
    ["7", "example"],
    ["8", "example"],
    ["9", "example"],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black, fontSize: Font.size_largeText),
            children: <TextSpan>[
              TextSpan(text: sentences[widget.chat.metaData!['step'] % 10][0]),
              TextSpan(text: widget.chat.content, style: TextStyle(fontWeight: Font.weight_bold)),
              TextSpan(text: sentences[widget.chat.metaData!['step'] % 10][1]),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 20),
          child: Image.asset(
            "lib/assets/images/others/il_onway.png",
            width: MediaQuery.of(context).size.width * 0.4,
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () {
              context.read<ChatProvider>().postChat(context, "text",
                  metaData: {'type_code': "onway", 'step': widget.chat.metaData!['step'] + 10});
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                overlayColor: MaterialStateProperty.all(Coloring.gray_50),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 15, horizontal: 6))),
            child: Text(
              "수락",
              style: TextStyle(color: Colors.black, fontSize: Font.size_largeText, fontWeight: Font.weight_regular),
            ),
          ),
        ),
      ],
    );
  }
}

class DialogOnwaySecondWidget extends StatelessWidget {
  DialogOnwaySecondWidget({Key? key, required this.chat}) : super(key: key);

  final Chat chat;
  final List<String> sentences = [
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                "오는 길에 수락",
                style: TextStyle(color: Colors.blue[300], fontSize: Font.size_mediumText, fontWeight: Font.weight_bold),
              ),
            ),
          ],
        ),
        Text(sentences[chat.metaData!['step'] % 10]),
      ],
    );
  }
}
