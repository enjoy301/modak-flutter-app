import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/data/dto/letter.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/ui/chat/letter/chat_letter_VM.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:provider/provider.dart';

class ChatLetterDetailScreen extends StatelessWidget {
  const ChatLetterDetailScreen({Key? key, required this.letter})
      : super(key: key);

  final Letter letter;

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, ChatLetterVM>(
      builder: (context, userProvider, provider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: headerDefaultWidget(
            title: "편지",
            leading: FunctionalIcon.back,
            onClickLeading: () {
              Get.back();
            },
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "To. ${userProvider.findUserById(letter.toMemberId)?.name ?? "익명"}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Font.size_h3,
                          fontWeight: Font.weight_regular,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      letter.content + "\n" * 19,
                      maxLines: 200,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: Row(
                      children: [
                        Expanded(child: Text("")),
                        Text(
                          "From. ${userProvider.findUserById(letter.fromMemberId)?.name ?? "익명"}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Font.size_h3,
                            fontWeight: Font.weight_regular,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
