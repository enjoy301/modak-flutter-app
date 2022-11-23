import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/data/dto/letter.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/ui/chat/letter/chat_letter_VM.dart';
import 'package:modak_flutter_app/utils/easy_style.dart';
import 'package:modak_flutter_app/widgets/common/scalable_text_widget.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:provider/provider.dart';

class ChatLetterDetailScreen extends StatelessWidget {
  const ChatLetterDetailScreen({Key? key, required this.letter})
      : super(key: key);

  final Letter letter;

  @override
  Widget build(BuildContext context) {
    final Map<EnvelopeType, dynamic> letterEnvelop = {
      EnvelopeType.red: {
        "background": Colors.white,
      },
      EnvelopeType.brown: {
        "background": Coloring.bg_red,
      },
      EnvelopeType.cyan: {
        "background": Coloring.bg_orange,
      },
      EnvelopeType.green: {
        "background": Coloring.bg_purple,
      }
    };

    return Consumer2<UserProvider, ChatLetterVM>(
      builder: (context, userProvider, provider, child) {
        return Scaffold(
          backgroundColor: Coloring.gray_50,
          appBar: headerDefaultWidget(
            title: "편지",
            leading: FunctionalIcon.back,
            onClickLeading: () {
              Get.back();
            },
          ),
          body: Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            decoration: BoxDecoration(
              color: (letterEnvelop[letter.envelope]['background'] as Color)
                  .withOpacity(0.5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ScalableTextWidget(
                          "To. ${userProvider.findUserById(letter.toMemberId)?.name ?? "익명"}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Font.size_h3,
                            fontWeight: Font.weight_bold,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: SizedBox(
                        width: double.infinity,
                        child: ScalableTextWidget(
                          letter.content + "\n" * 19,
                          style: EasyStyle.text(Colors.black,
                              Font.size_largeText, Font.weight_regular),
                          maxLines: 200,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Expanded(child: Text("")),
                          Text(
                            "From. ${userProvider.findUserById(letter.fromMemberId)?.name ?? "익명"}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Font.size_h3,
                              fontWeight: Font.weight_bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
